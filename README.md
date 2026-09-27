# BigCart

A full-stack grocery shopping platform: a Flutter mobile app and a React web client, both running on the same Express/GraphQL API backed by PostgreSQL.

<!-- REVIEW: the original opener was "A full-stack grocery shopping mobile app built with Flutter, Express, GraphQL, and PostgreSQL." — extended to cover the web client. The line below only applies to the mobile app now, so I moved it into the mobile bullet. -->

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
- **Backend API**:
  - Node.js, Express, TypeScript, GraphQL, Prisma ORM
  - Resolvers split by domain (auth, products, cart, orders, user); order creation runs in a single Prisma transaction
  - Auth: JWT middleware on every request, bcrypt password hashing, input validation on mutations
  - Transactional email (password recovery) via Resend
  - API tests with Vitest, run in CI
- **Database & Hosting**: PostgreSQL (Aiven), API hosted on Render
- **Media CDN**: Cloudinary for asset storage & dynamic delivery
- **Shared contract**: one GraphQL schema serves both clients; the backend exports it to SDL and the web client generates its types from that file.

<!-- REVIEW: the backend bullet was one line; I expanded it into a list like the two clients have, using only what's in the code (domain-split resolvers, $transaction on createOrder, is-auth middleware + bcryptjs + validator, Resend, Vitest tests in ci.yml). Cut anything you don't want called out. -->

## Features

- **Authentication & Security**: Email/Password registration & login with phone OTP verification flow (no SMS messaging implemented, code is always 123456), email-based password recovery with Resend, and JWT session persistence.
- **Account & Profile Management**: Update personal info (name, email, phone), password change, profile picture upload via Cloudinary, and notification preferences.
- **Address & Card Management**: Manage saved shipping addresses and payment methods with default selection support.
- **Product Catalog**: Categorized products with multi-parameter filtering (price range, ratings, same-day delivery, discounts) and search.
- **Cart & Favorites**: Real-time subtotal & total calculation with support for discounts, item quantity adjustment, and swipe-to-delete actions on mobile.
- **Checkout & Orders**: Multi-step checkout pipeline and order history with dynamic 5-stage status timeline.
- **Reviews & Ratings**: Product reviews with ratings.
- **CI/CD & DevOps**: GitHub Actions pipeline — Flutter, Node.js and React tests, a Playwright end-to-end checkout run in a real browser, and automated Render deployment when the backend changes.

<!-- REVIEW: the web tests are unit/component (Vitest + Testing Library + MSW: GraphQL error handling, optimistic rollback, form validation timing, remove-confirm) plus one Playwright flow (sign up → cart → checkout → track). The e2e job signs up a throwaway `e2e+<timestamp>@example.com` account on the live DB every push — drop the `web-e2e` job from ci.yml if you'd rather run it only locally with `npm run test:e2e`. -->

### Web client

- Filters, search and category are URL parameters: any view is a link, and it survives refresh.
- Cart and favourites update optimistically with rollback; removing the last unit of an item asks first.
- Three-step checkout (delivery, address, payment) with saved addresses and cards preselected from your defaults; adding a new one on checkout saves it to the account.
- Account area as a nested layout: profile and password, orders with tracking, addresses, cards, transactions, notification preferences.
- Router-level error boundaries and a 404 page.

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

<!-- REVIEW: two suggestions here. (1) `backend/.env.example` now exists — "copy .env.example to .env and fill it in" is friendlier than listing the variables. (2) NODE_TLS_REJECT_UNAUTHORIZED=0 disables certificate checking for the whole Node process, which reads badly to a reviewer. The narrower fix is `sslmode=no-verify` on DATABASE_URL (or Aiven's CA cert); worth switching and dropping this from the instructions. -->

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

## Notes

- Web types are generated from the backend schema; nothing API-shaped is written by hand.
- One RTK Query API slice for the whole web app; a custom base query maps GraphQL's `errors` array to real errors.
- Page state (search, filters, checkout selections) lives in the URL. Redux holds the session token and the query cache, nothing else.
- Cart and favourite changes are optimistic with rollback.
- JWTs expire after one day; no refresh tokens.
- Addresses and cards added during checkout are saved to the account first. Neither client deletes them, since orders reference them.
- OTP is a fixed code and Google sign-in is a placeholder that says so.
