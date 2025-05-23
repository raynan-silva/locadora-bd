/*
    Consulta para obter os 50 modelos de carro com mais alugueis, mostrando detalhes da quantidade de alugueis,
    valor médio dos alugueis e a duração média dos alugueis
*/

SELECT 
  ca.modelo,
  COUNT(*) AS total_alugueis,
  AVG(a.valor) AS media_valor,
  AVG(DATEDIFF(a.data_prevista_devolucao, a.data_inicial)) AS duracao_media
FROM aluguel a
JOIN carro ca ON ca.id = a.carro_id
GROUP BY ca.modelo
ORDER BY total_alugueis DESC
LIMIT 50;
