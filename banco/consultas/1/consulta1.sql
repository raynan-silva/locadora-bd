/*
    Consulta para obter detalhes dos 100 aluguéis com as maiores multas
*/

SELECT 
  c.nome as nome_cliente,
  ca.placa,
  ca.modelo as modelo_carro,
  a.data_inicial,
  a.data_prevista_devolucao,
  a.data_devolvido,
  calcular_multa(a.data_prevista_devolucao, a.data_devolvido, a.valor, a.multa_por_dia_atrasado) AS multa
FROM aluguel a
JOIN cliente c ON c.id = a.cliente_id
JOIN carro ca ON ca.id = a.carro_id
WHERE a.data_devolvido > a.data_prevista_devolucao
ORDER BY multa DESC
LIMIT 100;
