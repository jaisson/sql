select p.dtemissao,
       c.nmCliente "Cliente",     
       (select sum(pi.quantidade * pi.vlrUnitario) total
          from pedido_item pi
         where pi.cdPedido = p.idPedido) total_itens
  from pedido p
  join cliente c on (c.idCliente = p.cdCliente)
 where (select count(1)
          from pedido_item pi
         where pi.cdPedido = p.idPedido) > 5

select p.dtemissao,
       c.nmCliente "Cliente",     
       sum((pi.quantidade * pi.vlrUnitario)) total_itens
  from pedido p
  join cliente c on (c.idCliente = p.cdCliente)
  join pedido_item pi on (pi.cdPedido = p.idPedido)
 where p.dtemissao >= sysdate -7
   and c.cdMunicipio in (select m.idMunicipio
                           from municipio m
                          where m.dsUF = 'RS')
 group by p.dtemissao, c.nmCliente


select ename, sal, job, deptno
  from emp
 where sal > ANY (select distinct
                         sal
                    from emp
                   where deptno = 30);

select ename, sal, job, deptno
  from emp
 where sal > ALL (select distinct
                         sal
                    from emp
                   where deptno = 30);

select m.empno,m.ename,m.job,m.deptno
  from emp m
 where exists (select e.empno
                from emp e
               where e.mgr=m.empno);

select idProduto,
       dsProduto,
       vlrUnitario
  from products
 where (tpProduto, vlrUnitario) IN (select tpProduto, MIN(vlrUnitario)
                                      from products
                                     group by tpProduto);

select roma.numerocm, extract(year from roma.dtemissao) ano,
       sum((((case 
                when exists (select *
                              from romatransf tsi
                             where (tsi.estab        = roma.estab) 
                               and (tsi.romaneio     = roma.romaneio)
                               and (tsi.entradasaida = roma.entradasaida) 
                               and (tsi.numerocm     = roma.numerocm))
                  then (select coalesce(sum(tsi.quantidade) ,0)
                          from romatransf tsi 
                         where (tsi.estab        = roma.estab) 
                           and (tsi.romaneio     = roma.romaneio) 
                           and (tsi.entradasaida = roma.entradasaida) 
                           and (tsi.numerocm     = roma.numerocm)
                           and not exists (select *
                                             from u_roma_invalido
                                            where estab = tsi.estab
                                              and entradasaida = tsi.entradasaida
                                              and numerocm = tsi.numerocmtransf))
                else roma.pesoliquido
              end))))  pesoliquido
  from roma
  join itemagro on (itemagro.item = roma.item)
  join pessoas on (pessoas.numerocm = roma.numerocm)
 WHERE roma.romaneioconfig in (select romaneioconfig
                                 from romacfg
                                where movprod = 'S')
   and (itemagro.grupo in (1088, 1090))
   and roma.dtemissao >= to_date('01/01/2023', 'DD/MM/YYYY')
 group by roma.numerocm, extract(year from roma.dtemissao);



SELECT FILIAL.REDUZIDO ORIGEM,
       NFCAB.DTEMISSAO, NFCAB.NOTA,
       DESTINO.REDUZIDO DESTINO,
       ITEMAGRO.ITEM, ITEMAGRO.DESCRICAO,
       NFITEM.QUANTIDADE QTDE_SAIDA,
       NFITEM.VALORTOTAL VLR_SAIDA,
       NFPE.DTENTRADA , NFPE.ROMANEIO ROMANEIO_ENTRADA,
       NFPE.QUANTIDADE QTDE_ENTRADA, NFPE.VALORTOTAL VLR_ENTRADA
  FROM NFCAB
  JOIN FILIAL ON (FILIAL.ESTAB = NFCAB.ESTAB)
  JOIN FILIAL DESTINO ON (DESTINO.ESTAB = NFCAB.NUMEROCM)
  JOIN NFITEM ON (NFITEM.ESTAB = NFCAB.ESTAB) AND (NFITEM.SEQNOTA = NFCAB.SEQNOTA)
  JOIN ITEMAGRO ON (ITEMAGRO.ITEM = NFITEM.ITEM)
  LEFT JOIN (
         SELECT N.ESTAB, P.CHAVEACESSONFP CHAVEACESSONFE,
                N.DTEMISSAO DTENTRADA,
                NFI.ROMANEIO, NFI.QUANTIDADE, NFI.VALORTOTAL
           FROM NFCAB N
           JOIN NFITEM NFI ON (NFI.ESTAB = N.ESTAB) AND (NFI.SEQNOTA = N.SEQNOTA)
           JOIN NFCABPRODUTOR P ON (P.ESTAB = N.ESTAB) AND (P.SEQNOTA = N.SEQNOTA)
          WHERE N.NOTACONF = 1101
       ) NFPE ON (NFPE.CHAVEACESSONFE = NFCAB.CHAVEACESSONFE)
 WHERE NFCAB.NOTACONF = 1100
   AND NFCAB.STATUS = 'N'
   AND NFCAB.DTEMISSAO BETWEEN :DTINICIO AND :DTFIM
 ORDER BY NFCAB.DTEMISSAO DESC


SELECT ....
       NFPRODUTOR.NFPRODUTOR || '/' || NFPRODUTOR.SERIENFPRODUTOR NFP,
       SUM(NFITEM.QUANTIDADE) QUANTIDADE,
       COALESCE(IMPOSTOS.VLRIMPOSTO, 0) IMPOSTOS,
       COALESCE((SELECT ROMADESC.REFTABELA
                   FROM ROMADESC
                  WHERE (ROMADESC.ESTAB = NFCAB.ESTAB)
                    AND (ROMADESC.ROMANEIO = ROMANEIO.ROMANEIO)
                    AND (ROMADESC.ENTRADASAIDA = 'E')
                    AND (ROMADESC = 2)
                    AND (ROMADESC.NUMEROCM = NFCAB.NUMEROCM)), 0) IMPUREZA,
       ....
  FROM NFCAB
       ....
  LEFT JOIN LATERAL (SELECT SUM(I.VALORIMPOSTO) VLRIMPOSTO
                       FROM NFCABIMPOSTO I
                       JOIN IMPOSTO_U U ON (U.IMPOSTO = I.IMPOSTO)
                      WHERE I.ESTAB = NFCAB.ESTAB
                        AND I.SEQNOTA = NFCAB.SEQNOTA) IMPOSTOS ON (1=1)
  LEFT JOIN LATERAL (SELECT NFPRODUTOR, SERIENFPRODUTOR
                       FROM NFCABPRODUTOR NFP
                      WHERE NFP.ESTAB = NFCAB.ESTAB
                        AND NFP.SEQNOTA = NFCAB.SEQNOTA
                        AND ROWID = (SELECT MAX(ROWID)
                                       FROM NFCABPRODUTOR NFPI
                                      WHERE NFPI.ESTAB = NFP.ESTAB
                                        AND NFPI.SEQNOTA = NFP.SEQNOTA)) NFPRODUTOR ON (1=1)
  LEFT JOIN LATERAL (SELECT MAX(ROMANEIO) ROMANEIO
                       FROM NFCABROMA
                      WHERE NFCABROMA.ESTAB = NFCAB.ESTAB
                        AND NFCABROMA.SEQNOTA = NFCAB.SEQNOTA
                        AND NFCABROMA.NUMEROCM = NFCAB.NUMEROCM) ROMANEIO ON (1=1)
 WHERE ....
 GROUP BY ....
 ORDER BY ....
