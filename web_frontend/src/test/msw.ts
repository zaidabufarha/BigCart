import { http, HttpResponse, type JsonBodyType } from "msw";
import { setupServer } from "msw/node";

/**
 * Mock Service Worker intercepts `fetch` at the network layer, so the real
 * RTK Query slice and the real GraphQL base query run in tests — only the
 * server's answer is faked. That's what lets a test prove behaviour like
 * "a 200 with an errors array becomes an error" or "a failed mutation rolls
 * the optimistic update back".
 */
export const API_URL = import.meta.env.VITE_API_URL as string;

export const server = setupServer();

/** Answer the next GraphQL POST with this body and status. */
export function mockGraphql(body: JsonBodyType, status = 200) {
  server.use(http.post(API_URL, () => HttpResponse.json(body, { status })));
}

/** Answer the next GraphQL POST with a non-JSON body (an HTML error page, say). */
export function mockText(body: string, status: number, contentType = "text/html") {
  server.use(
    http.post(API_URL, () => new HttpResponse(body, { status, headers: { "Content-Type": contentType } })),
  );
}
