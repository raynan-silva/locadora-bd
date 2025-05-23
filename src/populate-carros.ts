import { faker } from '@faker-js/faker';
import { createConnection } from './db';

const TOTAL_CARROS = 1_000_000;
const BATCH_SIZE = 100_000;
const CORES = ['Preto', 'Branco', 'Prata', 'Azul', 'Vermelho', 'Cinza'];

async function main() {
  const conn = await createConnection();

  console.log("Conexão estabelicida!")

  console.log("Iniciando inserção de dados!")

  for (let i = 0; i < TOTAL_CARROS; i += BATCH_SIZE) {
    const values: any[] = [];

    for (let j = 0; j < BATCH_SIZE; j++) {
      const placa = faker.string.alphanumeric({ length: 3, casing: 'upper' }) + '-' + faker.string.numeric(4);
      const cor = faker.helpers.arrayElement(CORES);
      const chassi = faker.string.alphanumeric(17).toUpperCase();
      const ano = faker.date.between({ from: '2000-01-01', to: '2023-12-31' }).getFullYear();
      const modelo = faker.vehicle.model();

      values.push([placa, cor, chassi, ano, modelo]);
    }

    await conn.query(
      'INSERT IGNORE INTO carro (placa, cor, chassi, ano, modelo) VALUES ?',
      [values]
    );

    console.log(`🚗 Inseridos ${Math.min(i + BATCH_SIZE, TOTAL_CARROS)} carros`);
  }

  await conn.end();
}

main();
