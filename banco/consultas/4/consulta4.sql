/*
  Consulta para obter os 100 clientes que mais pagaram multa devido atraso da devolução
*/

SELECT 
  c.nome,
  SUM(calcular_multa(a.data_prevista_devolucao, a.data_devolvido, a.valor, a.multa_por_dia_atrasado)) AS total_multa
FROM aluguel a
JOIN cliente c ON c.id = a.cliente_id
GROUP BY c.id
ORDER BY total_multa DESC
LIMIT 100;
