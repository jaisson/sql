with
clientes as (
    select 123 idPessoa, 'Jaisson' nmCliente, to_date('20/03/1990', 'DD/MM/YYYY') dtnascimento from dual
     union all
    select 321, 'Frederico', to_date('15/08/1995', 'DD/MM/YYYY') dtnascimento from dual
),

fornecedor as (
    select 123 idPessoa, 'jaisson@empresa.com.br' dsEmail from dual
     union all
    select 321 idFornecedor, 'frederico@empresa.com.br' dsEmail from dual
)

 select *
   from clientes
natural join fornecedor