DELIMITER $$

CREATE FUNCTION calcular_multa(
  p_data_prevista DATE,
  p_data_devolvido DATE,
  p_valor DECIMAL(7,2),
  p_multa_por_dia DECIMAL(7,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE dias_atraso INT;
  DECLARE multa_total DECIMAL(10,2);

  IF p_data_devolvido > p_data_prevista THEN
    SET dias_atraso = DATEDIFF(p_data_devolvido, p_data_prevista);
    SET multa_total = (p_valor * 0.10) + (dias_atraso * p_multa_por_dia);
  ELSE
    SET multa_total = 0;
  END IF;

  RETURN multa_total;
END $$

DELIMITER ;