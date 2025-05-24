DELIMITER $$

CREATE TRIGGER trg_set_multa_default
BEFORE INSERT ON aluguel
FOR EACH ROW
BEGIN
  IF NEW.multa_por_dia_atrasado IS NULL THEN
    SET NEW.multa_por_dia_atrasado = NEW.valor * 0.15;
  END IF;
END $$

DELIMITER ;
