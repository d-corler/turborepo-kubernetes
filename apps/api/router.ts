import express from "express";

const router = express.Router();

// Import controllers

import * as usersController from "./controllers/users";

/// USER ------------------------------------------------------------------ ///

// GET request to read an user.
router.get("/", usersController.readOne);

/// ----------------------------------------------------------------------- ///

export default router;
