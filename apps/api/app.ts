// import "@abraham/reflection";
import express from "express";
// import { injectable } from "tsyringe";

import router from "./router";

const app = express();

app.use(router);

if (process.env.NODE_ENV === "production") {
  app.listen(3000);
}

export const viteNodeApp = app;
