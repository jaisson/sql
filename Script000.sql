SELECT P.nmPessoa "Pessoa",
       D.nmDependente "Dependente"
  FROM PESSOA P
  JOIN DEPENDENTE D USING (cdPessoa)
  
