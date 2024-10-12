// IMPORTACIONES POR PAQUETES
const express = require("express");
const mongoose = require("mongoose");

// IMPORTACIONES DE OTROS ARCHIVOS
const authRouter = require("./routes/auth");

// INICIALIZACIÓN
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://changesteam1234:ignacio123@cluster0.gb0xq.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"

// middleware
app.use(authRouter);

// conexiones
mongoose
  .connect(DB)
  .then(() => {
    console.log("Conexión Exitosa");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, () => {
  console.log("Conexión al puerto " + PORT);
});
