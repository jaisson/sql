insert into pedido (cdPessoa, dtEmissao, stSitucao)
select round(dbms_random.value(1, (select count(1) from pessoa))) cdPessoa,
       trunc(to_date('15/08/2020', 'DD/MM/YYYY') + DBMS_RANDOM.VALUE() * (trunc(sysdate) - to_date('15/08/2020', 'DD/MM/YYYY'))) dtEmissao,
       decode(mod((round(DBMS_RANDOM.VALUE() * 1000) + round(DBMS_RANDOM.VALUE() * 1000)), 2), 0, 'C', 'N') stSitucao
  from dual
connect by level <= 5000;

insert into pedido_produto (cdPedido, cdProduto, qtdProduto, vlrUnitario)
select round(dbms_random.value(1, 50000)) cdPedido,
       round(dbms_random.value(1, 280)) cdProduto,
       round(dbms_random.value(1, 5)) qtdProduto,
       round(DBMS_RANDOM.VALUE() * 1000, 2) vlrUnitario
  from dual
connect by level <= 15000;