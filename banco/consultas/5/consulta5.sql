/*
    Consulta para retornar o status dos alugueis em andamento
*/

SELECT 
  a.id,
  DATEDIFF(data_devolvido, data_prevista_devolucao) AS dias_atraso,
  CASE 
    WHEN data_devolvido > data_prevista_devolucao THEN 'Atrasado'
    WHEN data_devolvido = data_prevista_devolucao THEN 'No Prazo'
    ELSE 'Adiantado'
  END AS status_devolucao
FROM aluguel
WHERE data_devolvido IS NOT NULL
ORDER BY dias_atraso DESC
LIMIT 200;
