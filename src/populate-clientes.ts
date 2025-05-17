import { faker } from '@faker-js/faker';
import { generate as generateCPF } from 'gerador-validador-cpf';
import { createConnection } from './db';

const TOTAL_CLIENTES = 3942;
const BATCH_SIZE = 10000;

async function main() {
  const conn = await createConnection();

  for (let i = 0; i < TOTAL_CLIENTES; i += BATCH_SIZE) {
    const values: any[] = [];

    for (let j = 0; j < BATCH_SIZE; j++) {
      const name = faker.person.fullName();
      const email = faker.internet.email();
      const birthDate = faker.date.birthdate({ min: 1950, max: 2005, mode: 'year' });
      const cpf = generateCPF();

      values.push([name, email, birthDate.toISOString().split('T')[0], cpf]);
    }

    await conn.query(
      'INSERT IGNORE INTO cliente (nome, email, data_nascimento, cpf) VALUES ?',
      [values]
    );

    console.log(`✅ Inseridos ${Math.min(i + BATCH_SIZE, TOTAL_CLIENTES)} clientes`);
  }

  await conn.end();
}

main();
