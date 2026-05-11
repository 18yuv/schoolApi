import mysql from "mysql2"

const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  port: process.env.DB_PORT, 
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

connection.connect((err) => {
  if (err) {
    console.log("Database Connection Failed:", err);
  } else {
    console.log("MySQL Connected");
  }
});

export default connection;