CREATE SCHEMA IF NOT EXISTS locadora DEFAULT CHARACTER SET utf8 ;
USE locadora ;

DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS carro;
DROP TABLE IF EXISTS aluguel;
-- -----------------------------------------------------
-- Tabela cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cliente (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  email VARCHAR(250) NOT NULL,
  data_nascimento DATE NOT NULL,
  cpf VARCHAR(11) NOT NULL,
  criado_em DATETIME NOT NULL DEFAULT now(),
  PRIMARY KEY (id),
  UNIQUE INDEX email_UNIQUE (email ASC) VISIBLE,
  UNIQUE INDEX cpf_UNIQUE (cpf ASC) VISIBLE
);


-- -----------------------------------------------------
-- Tabela carro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS carro (
  id INT NOT NULL AUTO_INCREMENT,
  placa VARCHAR(8) NOT NULL,
  cor VARCHAR(45) NOT NULL,
  chassi VARCHAR(45) NOT NULL,
  ano YEAR(4) NOT NULL,
  modelo VARCHAR(250) NOT NULL,
  criado_em DATETIME NOT NULL DEFAULT now(),
  UNIQUE INDEX placa_UNIQUE (placa ASC) VISIBLE,
  UNIQUE INDEX chassi_UNIQUE (chassi ASC) VISIBLE,
  PRIMARY KEY (id)
);


-- -----------------------------------------------------
-- Tabela aluguel
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS aluguel (
  id INT NOT NULL AUTO_INCREMENT,
  cliente_id INT NOT NULL,
  carro_id INT NOT NULL,
  data_inicial DATE NOT NULL,
  data_prevista_devolucao DATE NOT NULL,
  data_devolvido DATE,
  multa_por_dia_atrasado DECIMAL(7,2) NULL,
  valor DECIMAL(7,2) NOT NULL,
  criado_em DATETIME NOT NULL DEFAULT now(),
  PRIMARY KEY (id, cliente_id, carro_id),
  INDEX fk_cliente_has_carro_carro1_idx (carro_id ASC) VISIBLE,
  INDEX fk_cliente_has_carro_cliente_idx (cliente_id ASC) VISIBLE,
  CONSTRAINT fk_cliente_has_carro_cliente
    FOREIGN KEY (cliente_id)
    REFERENCES cliente (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_cliente_has_carro_carro1
    FOREIGN KEY (carro_id)
    REFERENCES carro (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
