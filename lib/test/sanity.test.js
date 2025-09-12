"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const index_1 = require("../src/index");
test("ping", () => {
  expect((0, index_1.ping)()).toBe("pong");
});
