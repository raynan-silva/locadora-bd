import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
dotenv.config();

export const createConnection = async () => {
  return mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
  });
};
