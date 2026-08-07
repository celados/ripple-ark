import { describe, expect, test } from "vitest";
import * as api from "../src";

describe("public surface", () => {
  test("covers every current Zag component machine", () => {
    const hooks = Object.keys(api).filter((name) => name.startsWith("use"));

    expect(hooks).toHaveLength(50);
    expect(hooks).toContain("useDateInput");
    expect(hooks).toContain("useDrawer");
    expect(hooks).toContain("useMarquee");
    expect(hooks).toContain("useNavigationMenu");
    expect(hooks).toContain("useToggle");
  });
});
