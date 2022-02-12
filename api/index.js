const express = require("express");
const app = express();
const dotenv = require("dotenv");

const PORT = process.env.PORT || 4051;

app.get("/", (req, res) => {
  res.send(`Hey it's working !!`);
});
app.listen(PORT,'192.168.56.1', () => console.log(`server up and running at  ${PORT}`));

const mongoose = require("mongoose");
const cors = require("cors");

const authRoute = require("./routes/auth/auth");
const eventRoute = require('./routes/event/event')
const authDashboard = require("./routes/auth/authDashboard");

dotenv.config();

mongoose.connect(
  process.env.DB_CONNECT,
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  },
  () => console.log("connected to db")
);

app.use(express.json(), cors());

app.use("/api/users", authRoute);
app.use("/api/events", eventRoute);
app.use("/api/dashboard", authDashboard);

