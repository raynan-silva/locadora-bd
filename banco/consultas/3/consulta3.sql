/*
    Consulta para obter o aluguel mais caro por cliente
*/

SELECT 
  c.nome,
  (SELECT MAX(valor) FROM aluguel a WHERE a.cliente_id = c.id) AS aluguel_mais_caro
FROM cliente c
ORDER BY aluguel_mais_caro DESC
LIMIT 100;
