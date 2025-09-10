import { ping } from "../src/index";
test("ping", () => {
  expect(ping()).toBe("pong");
});
