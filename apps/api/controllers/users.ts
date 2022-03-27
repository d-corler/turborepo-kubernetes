import type { RequestHandler } from "express";

export const readOne: RequestHandler = (req, res) =>
  res.send("User detail: " + req.query.id);
