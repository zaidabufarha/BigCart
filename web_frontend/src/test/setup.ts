import "@testing-library/jest-dom/vitest";
import { cleanup } from "@testing-library/react";
import { afterAll, afterEach, beforeAll } from "vitest";
import { baseApi } from "../app/service/baseApi";
import { store } from "../app/store";
import { server } from "./msw";

// jsdom lacks a few browser APIs Mantine touches on render.
window.matchMedia ??= (query: string) =>
  ({
    matches: false,
    media: query,
    onchange: null,
    addListener: () => {},
    removeListener: () => {},
    addEventListener: () => {},
    removeEventListener: () => {},
    dispatchEvent: () => false,
  }) as MediaQueryList;

class ResizeObserverStub {
  observe() {}
  unobserve() {}
  disconnect() {}
}
window.ResizeObserver ??= ResizeObserverStub as unknown as typeof ResizeObserver;
Element.prototype.scrollIntoView ??= () => {};

// Any request a test didn't explicitly mock is a bug in the test, not a
// network call to make.
beforeAll(() => server.listen({ onUnhandledRequest: "error" }));

afterEach(() => {
  server.resetHandlers();
  cleanup();
  // the app store is a singleton; wipe the query cache so tests can't leak
  // into each other
  store.dispatch(baseApi.util.resetApiState());
});

afterAll(() => server.close());
