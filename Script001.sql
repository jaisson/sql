select (select count(1) from pessoa) total_pessoas,
       dbms_random.value(1, (select count(1) from pessoa)) nr_aleatorio,
       trunc(15.255795425654) truncar,
       floor(15.255795425654) floor,
       round(15.255795425654) round1,
       round(15.255795425654, 2) round2,

       round(dbms_random.value(1, (select count(1) from pessoa))) cdPessoa,
       trunc(to_date('15/08/2020', 'DD/MM/YYYY') + DBMS_RANDOM.VALUE() * (trunc(sysdate) - to_date('15/08/2020', 'DD/MM/YYYY'))) dtEmissao,
       decode(mod((round(DBMS_RANDOM.VALUE() * 1000) + round(DBMS_RANDOM.VALUE() * 1000)), 2), 0, 'C', 'N') stSitucao
  from dual;



select
/*
       current_date,
       current_timestamp,
       sysdate,
       systimestamp,
       trunc(sysdate) dia_hoje
*/
/*
       DBMS_RANDOM.VALUE() nr_aleatorio, 
       dbms_random.value(1, 10) nr_aleatorio_entre,
       round(DBMS_RANDOM.VALUE() * 1000) nr_aleatorio_inteiro,
       trunc(15.255795425654) truncar,
       floor(15.255795425654) floor,
       round(15.255795425654) round1,
       round(15.255795425654, 2) round2,
       mod(2, 2) par,
       mod(3, 2) impar
*/
/*
       decode(2, 2, 'Dois', 'Outro Número') operador_ternario,
       decode(mod(2, 2), 2, 'Par', 'Ímpar') par_impar
*/


       to_date('15/08/2020', 'DD/MM/YYYY') dt1,
       (select count(1) from pessoa) total_pessoas,
       
    
    
       trunc(to_date('15/08/2020', 'DD/MM/YYYY') + DBMS_RANDOM.VALUE() * (trunc(sysdate) - to_date('15/08/2020', 'DD/MM/YYYY'))) dtEmissao,

    
       round(dbms_random.value(1, (select count(1) from pessoa))) cdPessoa,
       trunc(to_date('15/08/2020', 'DD/MM/YYYY') + DBMS_RANDOM.VALUE() * (trunc(sysdate) - to_date('15/08/2020', 'DD/MM/YYYY'))) dtEmissao,
       decode(mod((round(DBMS_RANDOM.VALUE() * 1000) + round(DBMS_RANDOM.VALUE() * 1000)), 2), 0, 'C', 'N') stSitucao
    */
  from dual