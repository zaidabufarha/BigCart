import { defineConfig, mergeConfig } from "vitest/config";
import viteConfig from "./vite.config.ts";

// Unit and component tests. Playwright's end-to-end tests live in e2e/ and
// are run separately (npm run test:e2e), so they're excluded here.
export default mergeConfig(
  viteConfig,
  defineConfig({
    test: {
      environment: "jsdom",
      setupFiles: ["./src/test/setup.ts"],
      include: ["src/**/*.test.{ts,tsx}"],
      css: false,
      // Unit tests never reach a real server (MSW answers every request), so
      // the API URL is a fixed fake — no .env needed locally or in CI.
      env: { VITE_API_URL: "http://api.test/graphql" },
    },
  }),
);
