import { faker } from '@faker-js/faker';
import { RowDataPacket } from 'mysql2/promise';
import { createConnection } from './db';

const TOTAL_ALUGUEIS = 5_000_000;
const BATCH_SIZE = 100_000;

type MaxResult = { maxRes: number } & RowDataPacket;

async function main() {
  const conn = await createConnection();

  console.log("Conexão estabelicida!")

  console.log("Iniciando inserção de dados!")

  const [rowsCli] = await conn.query<MaxResult[]>('SELECT MAX(id) as maxRes FROM cliente');
  const maxCli = rowsCli[0]?.maxRes ?? 0;

  const [rowsCar] = await conn.query<MaxResult[]>('SELECT MAX(id) as maxRes FROM carro');
  const maxCar = rowsCar[0]?.maxRes ?? 0;

  for (let i = 0; i < TOTAL_ALUGUEIS; i += BATCH_SIZE) {
    const values: any[] = [];

    for (let j = 0; j < BATCH_SIZE; j++) {
      const clienteId = faker.number.int({ min: 1, max: maxCli });
      const carroId = faker.number.int({ min: 1, max: maxCar });

      const dataInicial = faker.date.between({ from: '2019-01-01', to: '2023-01-01' });
      const dias = faker.number.int({ min: 1, max: 30 });

      const dataPrevista = new Date(dataInicial);
      dataPrevista.setDate(dataInicial.getDate() + dias);

      const scenario = faker.number.int({ min: 1, max: 100 });
      const dataDevolvido = new Date(dataPrevista);

      if (scenario <= 30) {
        // devolvido antes do prazo
        dataDevolvido.setDate(dataPrevista.getDate() - faker.number.int({ min: 1, max: 3 }));
      } else if (scenario <= 70) {
        // devolvido no prazo
        // não altera a data
      } else {
        // devolvido com atraso
        dataDevolvido.setDate(dataPrevista.getDate() + faker.number.int({ min: 1, max: 20 }));
      }

      const multa = faker.number.float({ min: 5, max: 50, fractionDigits: 2 });
      const valor = faker.number.float({ min: 100, max: 2000, fractionDigits: 2 });

      values.push([
        clienteId,
        carroId,
        dataInicial.toISOString().split('T')[0],
        dataPrevista.toISOString().split('T')[0],
        dataDevolvido.toISOString().split('T')[0],
        multa,
        valor,
      ]);
    }

    await conn.query(
      `INSERT IGNORE INTO aluguel (
        cliente_id, carro_id, data_inicial, data_prevista_devolucao, data_devolvido, multa_por_dia_atrasado, valor
      ) VALUES ?`,
      [values]
    );

    console.log(`📦 Inseridos ${Math.min(i + BATCH_SIZE, TOTAL_ALUGUEIS)} aluguéis`);
  }

  await conn.end();
}

main();
