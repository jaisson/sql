select extract(month from nota.dtemissao) mes,
       cidade.nmcidade cidade,
       sum(nfcab.valor) total
  from nota
  join pessoa on (pessoa.idpessoa = nota.cdpessoa)
  join cidade on (cidade.idcidade = pessoa.cdcidade)
 where nota.dtemissao >= to_date('01/01/2023', 'DD/MM/YYYY')
   and cidade.nmcidade in ('CRUZ ALTA', 'IBIRUBA', 'QUINZE DE NOVEMBRO')
 group by extract(month from nota.dtemissao),
       cidade.nome
 order by mes, cidade
 