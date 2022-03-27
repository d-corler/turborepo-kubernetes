"use strict";
Object.defineProperties(exports, { __esModule: { value: true }, [Symbol.toStringTag]: { value: "Module" } });
var express = require("express");
function _interopDefaultLegacy(e) {
  return e && typeof e === "object" && "default" in e ? e : { "default": e };
}
var express__default = /* @__PURE__ */ _interopDefaultLegacy(express);
const readOne = (req, res) => res.send("User detail: " + req.query.id);
const router = express__default["default"].Router();
router.get("/", readOne);
const app = express__default["default"]();
app.use(router);
if (process.env.NODE_ENV === "production") {
  app.listen(3e3);
}
const viteNodeApp = app;
exports.viteNodeApp = viteNodeApp;
