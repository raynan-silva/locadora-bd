use locadora;

DELIMITER $$

CREATE PROCEDURE povoar_cliente(IN num_cliente INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE random_email VARCHAR(255);
    DECLARE chars CHAR(36) DEFAULT 'abcdefghijklmnopqrstuvwxyz0123456789';
    DECLARE c1, c2, c3, c4, c5, c6, c7, c8 VARCHAR(1);

    WHILE i <= num_cliente DO
        -- Gera 8 caracteres aleatórios para o email
        SET c1 = SUBSTRING(chars, FLOOR(1 + RAND() * 36), 1);
        SET c2 = SUBSTRING(chars, FLOOR(1 + RAND() * 36), 1);
        SET c3 = SUBSTRING(chars, FLOOR(1 + RAND() * 36), 1);
        SET c4 = SUBSTRING(chars, FLOOR(1 + RAND() * 36), 1);
        SET c5 = SUBSTRING(chars, FLOOR(1 + RAND() * 36), 1);
        SET c6 = SUBSTRING(chars, FLOOR(1 + RAND() * 36), 1);
        SET c7 = SUBSTRING(chars, FLOOR(1 + RAND() * 36), 1);
        SET c8 = SUBSTRING(chars, FLOOR(1 + RAND() * 36), 1);
        
        SET random_email = CONCAT(c1, c2, c3, c4, c5, c6, c7, c8, '@teste.com');

        INSERT IGNORE INTO cliente(nome, email, data_nascimento, cpf)
        VALUES (
            CONCAT('Nome', FLOOR(1 + (RAND() * 1000)), ' Sobrenome', FLOOR(1 + (RAND() * 1000))),
            random_email,
            DATE_ADD('1950-01-01', INTERVAL FLOOR(RAND() * 20000) DAY),
            LPAD(FLOOR(RAND() * 99999999999), 11, '0')
        );
        
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE povoar_carro(IN num_carro INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE letras CHAR(26) DEFAULT 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    WHILE i <= num_carro DO
        INSERT INTO carro(placa, cor, chassi, ano, modelo)
        VALUES (
            CONCAT(
                SUBSTRING(letras, FLOOR(1 + (RAND() * 26)), 1),
                SUBSTRING(letras, FLOOR(1 + (RAND() * 26)), 1),
                SUBSTRING(letras, FLOOR(1 + (RAND() * 26)), 1),
                LPAD(FLOOR(RAND() * 10000), 4, '0')
            ),
            ELT(FLOOR(1 + (RAND() * 7)), 'Preto', 'Branco', 'Cinza', 'Vermelho', 'Azul', 'Verde', 'Amarelo'),
            CONCAT('CHS', LPAD(FLOOR(RAND() * 1000000), 6, '0'), FLOOR(RAND() * 10)),
            FLOOR(2000 + (RAND() * 25)),
            CONCAT('Modelo', FLOOR(1 + (RAND() * 100)))
        );
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE povoar_aluguel(IN num_alugueis INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE cli_id INT;
    DECLARE car_id INT;
    DECLARE dias_previsto_dev INT;
    DECLARE dias_devolvido INT;
    DECLARE data_inicio DATE;
    
    WHILE i <= num_alugueis DO
        -- Seleciona cliente e carro válidos aleatoriamente
        SELECT id INTO cli_id FROM cliente ORDER BY RAND() LIMIT 1;
        SELECT id INTO car_id FROM carro ORDER BY RAND() LIMIT 1;
        
        SET dias_previsto_dev = FLOOR(1 + (RAND() * 30));
        SET dias_devolvido = FLOOR(1 + (RAND() * 45));
        SET data_inicio = DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 1500) DAY);

        -- Inserção real
        INSERT INTO aluguel(
            cliente_id, carro_id, data_inicial, data_prevista_devolucao,
            data_devolvido, multa_por_dia_atrasado, valor
        )
        VALUES (
            cli_id,
            car_id,
            data_inicio,
            DATE_ADD(data_inicio, INTERVAL dias_previsto_dev DAY),
            DATE_ADD(data_inicio, INTERVAL dias_devolvido DAY),
            ROUND(5 + (RAND() * 45), 2),
            ROUND(100 + (RAND() * 1900), 2)
        );

        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;
