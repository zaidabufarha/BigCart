import type { FetchBaseQueryError } from "@reduxjs/toolkit/query";
import { describe, expect, it } from "vitest";
import { logOut, setToken } from "../../features/auth/authSlice";
import { buyApi } from "../../features/buy/buyApi";
import { mockGraphql, mockText } from "../../test/msw";
import { store } from "../store";
import { toGraphqlError } from "./baseApi";

describe("toGraphqlError — turning a failed fetch into one message", () => {
  it("names a genuinely unreachable server", () => {
    const err = { status: "FETCH_ERROR", error: "TypeError: Failed to fetch" } as FetchBaseQueryError;
    expect(toGraphqlError(err)).toEqual({ status: 0, message: "Could not reach the server" });
  });

  it("names a timeout", () => {
    const err = { status: "TIMEOUT_ERROR", error: "timeout" } as FetchBaseQueryError;
    expect(toGraphqlError(err).message).toBe("The server took too long to respond");
  });

  it("prefers the GraphQL errors array inside a non-2xx body, joining several", () => {
    const err = {
      status: 400,
      data: { errors: [{ message: "Variable \"$number\" was not provided." }, { message: "Also this." }] },
    } as FetchBaseQueryError;
    expect(toGraphqlError(err)).toEqual({
      status: 400,
      message: 'Variable "$number" was not provided.; Also this.',
    });
  });

  it("falls back to a plain message field", () => {
    const err = { status: 500, data: { message: "boom" } } as FetchBaseQueryError;
    expect(toGraphqlError(err)).toEqual({ status: 500, message: "boom" });
  });

  it("falls back to the status code when the body says nothing useful", () => {
    const err = { status: 503, data: {} } as FetchBaseQueryError;
    expect(toGraphqlError(err).message).toBe("Request failed (HTTP 503)");
  });
});

describe("graphqlBaseQuery through a real endpoint", () => {
  it("treats a 200 with an errors array as a failure, keeping the resolver's message", async () => {
    mockGraphql({ data: null, errors: [{ message: "User not found, check the email and try again." }] });

    const result = await store.dispatch(buyApi.endpoints.getCategories.initiate());

    expect(result.error).toEqual({
      status: 400,
      message: "User not found, check the email and try again.",
    });
  });

  it("signs out when the server rejects the token (expired session)", async () => {
    // what the live API actually sends: HTTP 500, data null
    store.dispatch(setToken({ token: "expired.jwt.token", remember: true }));
    mockGraphql({ data: null, errors: [{ message: "Not authorized" }] }, 500);

    await store.dispatch(buyApi.endpoints.getCart.initiate());

    expect(store.getState().auth.token).toBeNull();
  });

  it("signs out on the same message inside a 200 too", async () => {
    store.dispatch(setToken({ token: "expired.jwt.token", remember: true }));
    mockGraphql({ data: null, errors: [{ message: "Not authorized" }] });

    await store.dispatch(buyApi.endpoints.getCart.initiate());

    expect(store.getState().auth.token).toBeNull();
  });

  it("keeps the session for any other error", async () => {
    store.dispatch(setToken({ token: "valid.jwt.token", remember: true }));
    mockGraphql({ data: null, errors: [{ message: "Not enough stock" }] });

    await store.dispatch(buyApi.endpoints.getCart.initiate());

    expect(store.getState().auth.token).toBe("valid.jwt.token");
    store.dispatch(logOut());
  });

  it("unwraps the single root field so components get the payload directly", async () => {
    const categories = [{ id: "1", name: "Fruits", image_path: "x.png", color: "4294961637" }];
    mockGraphql({ data: { categories } });

    const result = await store.dispatch(buyApi.endpoints.getCategories.initiate());

    expect(result.data).toEqual(categories);
  });

  it("reports an HTML 502 (Render's own error page) as malformed, keeping the real status", async () => {
    mockText("<html>Bad Gateway</html>", 502);

    const result = await store.dispatch(buyApi.endpoints.getCategories.initiate());

    // fetchBaseQuery tries to parse the body as JSON first, so this arrives as
    // a PARSING_ERROR rather than a plain 502 — the status survives either way
    expect(result.error).toEqual({ status: 502, message: "The server sent a malformed response" });
  });
});
