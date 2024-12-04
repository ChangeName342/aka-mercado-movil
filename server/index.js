// IMPORTACIONES POR PAQUETES
const express = require("express");
const mongoose = require("mongoose");
require("dotenv").config(); // Solo necesario si trabajas localmente con un archivo .env

// IMPORTACIONES DE OTROS ARCHIVOS
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

// INICIALIZACIÓN
const PORT = process.env.PORT || 3000;
const DB = process.env.MONGO_URI; // Obtenemos el URI desde las variables de entorno

const app = express();

// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// conexiones
mongoose
  .connect(DB, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => {
    console.log("Conexión Exitosa a MongoDB");
  })
  .catch((e) => {
    console.log("Error en la conexión:", e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Servidor corriendo en el puerto ${PORT}`);
});
