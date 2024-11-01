const jwt = require('jsonwebtoken');
const User = require('../models/user');

const admin = async (req, res, next) => {
    try {
        const token = req.header("x-auth-token");
        if (!token)
          return res
            .status(401)
            .json({ msg: "No tiene token de ingreso, acceso denegado!" });
    
        const verified = jwt.verify(token, "passwordKey");
        if (!verified)
          return res
            .status(401)
            .json({
              msg: "La verificación del token fracasó, autorización denegada!",
            });
        const user = await User.findById(verified.id);
        if (user.type == "user" || user.type == "seller") {
            return res.status(401).json({msg: "Usted no es un admin!"});
        }
        req.user = verified.id;
        req.token = token;
        next();
      } catch (err) {
        res.status(500).json({ error: err.message });
      }
}

module.exports = admin;