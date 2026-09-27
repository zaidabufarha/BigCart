# BigCart

A full-stack grocery shopping platform: a Flutter mobile app and a React web client, both running on the same Express/GraphQL API backed by PostgreSQL.

## Tech Stack & Architecture

- **Mobile Frontend**:
  - Flutter (Dart) with Clean Architecture (Domain, Data, and Presentation layers)
  - State Management: Cubit
  - Dependency Injection: `get_it` + `injectable`
  - Networking: Dio GraphQL client with automated token interceptors
  - Tested and optimized for Android
- **Web Frontend**:
  - React 19 + TypeScript, built with Vite; UI with Mantine
  - Data: Redux Toolkit + RTK Query — a single API slice with a custom GraphQL base query and optimistic updates with rollback
  - Routing: React Router v7; the account and checkout areas are nested layout routes, and search, filters and checkout selections live in the URL rather than in state
  - Types: GraphQL Code Generator produces schema types and per-operation types straight from the backend schema — no hand-written API models
  - Forms: `@mantine/form`, with a small custom hook for when errors appear — a field stays quiet until you leave it or try to submit, then its message updates live until the value is valid
  - Tests: Vitest + Testing Library, with MSW standing in for the server so the real RTK Query slice runs — covering GraphQL error handling, optimistic updates rolling back on failure, and form validation timing. A Playwright test drives Chromium through the whole flow against the live API: sign up a fresh account and enter the OTP, add a product to the cart, pick a shipping method, add an address and a card, place the order, and find it on the tracking page. Both run in CI.
- **Backend API**:
  - Node.js, Express, TypeScript, GraphQL, Prisma ORM
  - Resolvers split by domain (auth, products, cart, orders, user); order creation runs in a single Prisma transaction
  - Auth: JWT middleware on every request, bcrypt password hashing, input validation on mutations
  - Transactional email (password recovery) via Resend
  - API tests with Vitest, run in CI
- **Database & Hosting**: PostgreSQL (Aiven), API hosted on Render
- **Media CDN**: Cloudinary for asset storage & dynamic delivery
- **Shared contract**: one GraphQL schema serves both clients; the backend exports it to SDL and the web client generates its types from that file.

## Features

- **Authentication & Security**: Email/Password registration & login with phone OTP verification flow (no SMS messaging implemented, code is always 123456), email-based password recovery with Resend, and JWT session persistence.
- **Account & Profile Management**: Update personal info (name, email, phone), password change, profile picture upload via Cloudinary, and notification preferences.
- **Address & Card Management**: Manage saved shipping addresses and payment methods with default selection support.
- **Product Catalog**: Categorized products with multi-parameter filtering (price range, ratings, same-day delivery, discounts) and search.
- **Cart & Favorites**: Real-time subtotal & total calculation with support for discounts, item quantity adjustment, and swipe-to-delete actions on mobile.
- **Checkout & Orders**: Multi-step checkout pipeline and order history with dynamic 5-stage status timeline.
- **Reviews & Ratings**: Product reviews with ratings.
- **CI/CD & DevOps**: GitHub Actions pipeline — Flutter, Node.js and React tests, a Playwright end-to-end checkout run in a real browser, and automated Render deployment when the backend changes.

### Web client

- Filters, search and category are URL parameters: any view is a link, and it survives refresh.
- Cart and favourites update optimistically with rollback; removing the last unit of an item asks first.
- Three-step checkout (delivery, address, payment) with saved addresses and cards preselected from your defaults; adding a new one on checkout saves it to the account.
- Account area as a nested layout: profile and password, orders with tracking, addresses, cards, transactions, notification preferences.
- Router-level error boundaries and a 404 page.
- Pages other than home load on first visit, with a progress bar while they do.
- Responsive from phone to desktop: on phones, a drawer menu, a filter sheet, and account settings as a list of sections.

## Project Structure

```
backend/          Express + GraphQL API, Prisma schema, seed data, API tests
mobile_frontend/  Flutter app (features/<name>/{data,domain,presentation})
web_frontend/     React app (features/<name>/ with pages + api slice; shared components/, hooks/, lib/)
```

## Setup & Running

### 1. Backend

(create a .env file with DATABASE_URL, JWT_SECRET, RESEND_API_KEY, and NODE_TLS_REJECT_UNAUTHORIZED=0)

```bash
cd backend
npm install
npx prisma db push
npx tsx prisma/seed.ts
npm run dev
```

### 2. Mobile Frontend

```bash
cd mobile_frontend
flutter pub get
flutter run
```

### 3. Web Frontend

```bash
cd web_frontend
npm install
cp .env.example .env      # VITE_API_URL — the deployed API by default
npm run codegen           # generate TypeScript types from the backend schema
npm run dev
```

After changing the GraphQL schema: run `npm run schema:export` in `backend/`, then `npm run codegen` in `web_frontend/`. Any query that no longer matches the schema fails to type-check.

Tests (Node 22 or newer):

```bash
npm test                          # unit and component tests
npx playwright install chromium   # once, before the first end-to-end run
npm run test:e2e                  # sign up to order in a real browser
```

The end-to-end test signs up a new `e2e+<timestamp>@example.com` account on whichever API `VITE_API_URL` points at, so it can be re-run any number of times.

## Notes

- Web types are generated from the backend schema; nothing API-shaped is written by hand.
- One RTK Query API slice for the whole web app; a custom base query maps GraphQL's `errors` array to real errors.
- Page state (search, filters, checkout selections) lives in the URL. Redux holds the session token and the query cache, nothing else.
- Cart and favourite changes are optimistic with rollback.
- JWTs expire after one day; no refresh tokens.
- Addresses and cards added during checkout are saved to the account first. Neither client deletes them, since orders reference them.
- OTP is a fixed code and Google sign-in is a placeholder that says so.
- Password recovery emails send through Resend's shared test sender, which only delivers to the Resend account owner until a domain is verified. The flow works end to end; other inboxes won't receive it yet.
