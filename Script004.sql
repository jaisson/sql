WITH
nmTblTMP ([colunas]) AS (
  consulta sql
)
...

ou

WITH
nmTblTMP AS (
  consulta sql
)
...

with
cliente (idpessoa, nmpessoa) as (
  select 123 idPessoa, 'Jaisson Duarte' from dual
)

select * from cliente;

---------------------------------
---------------------------------
---------------------------------

with
cliente as (
  select 123 idPessoa, 'Jaisson Duarte' from dual
)

select * from cliente;
