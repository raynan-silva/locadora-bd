-- Índices para melhorar JOINs e WHEREs com cliente
CREATE INDEX idx_aluguel_cliente_id ON aluguel (cliente_id);

-- Índices para JOINs com carro
CREATE INDEX idx_aluguel_carro_id ON aluguel (carro_id);

-- Índice para filtro de devoluções com atraso
CREATE INDEX idx_aluguel_data_devolvido_prevista ON aluguel (data_devolvido, data_prevista_devolucao);

-- Índices para ordenação por multa (calculada via função, mas depende dessas colunas)
CREATE INDEX idx_aluguel_valor_multa ON aluguel (valor, multa_por_dia_atrasado);

-- Índice para ajudar na análise de aluguel mais caro por cliente
CREATE INDEX idx_aluguel_cliente_valor ON aluguel (cliente_id, valor DESC);

-- Índice para ajudar no agrupamento por modelo e agregações
CREATE INDEX idx_carro_modelo ON carro (modelo);

-- Índice para status de devolução
CREATE INDEX idx_aluguel_data_devolvido ON aluguel (data_devolvido);

-- Índice para análise geral por datas
CREATE INDEX idx_aluguel_datas ON aluguel (data_inicial, data_prevista_devolucao);
