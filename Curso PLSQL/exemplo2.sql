SELECT c.nmCidade AS "Cidade"
       COUNT(1) "Total Pessoas"
  FROM cidade c 
  JOIN ENDERECO e on (e.cdCidade = c.idCidade)
 WHERE c.dsUF = 'RS'
 GROUP BY c.nmCidade
HAVING COUNT(1) > 5000
 ORDER BY 1
 LIMIT 10
 