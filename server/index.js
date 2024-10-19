// IMPORTACIONES POR PAQUETES
const express = require("express");
const mongoose = require("mongoose");


// IMPORTACIONES DE OTROS ARCHIVOS
const authRouter = require("./routes/auth");

// INICIALIZACIÓN
const PORT = process.env.PORT || 3000;
const app = express();
const DB = 
  "mongodb+srv://ignacio123:tuki1234@cluster0.gb0xq.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
 
// middleware
app.use(express.json());
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

app.listen(PORT, "0.0.0.0", () => {
  console.log("Conexión al puerto " + PORT);
});
