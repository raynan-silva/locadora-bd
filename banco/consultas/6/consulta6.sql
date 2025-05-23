/*
    Consulta para obter relatório geral dos alugueis
*/

SELECT 
  COUNT(*) AS total_alugueis,
  SUM(valor) AS total_faturado,
  SUM(calcular_multa(data_prevista_devolucao, data_devolvido, valor, multa_por_dia_atrasado)) AS total_multas
FROM aluguel;
