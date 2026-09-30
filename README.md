# BigCart

A grocery shopping app with a Flutter mobile client and a React web client, both using the same Express and GraphQL API with a PostgreSQL database.

**Live web client:** https://big-cart-eight.vercel.app

## Tech Stack

**Mobile (Flutter)**
- Clean Architecture (domain, data, presentation)
- State: Cubit
- Dependency injection: `get_it` + `injectable`
- Networking: Dio, with the session token in secure storage (Android Keystore)
- Types generated with `graphql_codegen`, with one fragment per type (`ProductFields`, `OrderFields`, …) and one mapper per fragment
- Built and tested for Android

**Web (React)**
- React 19, TypeScript, Vite, Mantine
- Redux Toolkit and RTK Query. Redux only holds the session token and the query cache.
- React Router v7 with nested layouts. Search, filters, and checkout choices are kept in the URL, so any page can be shared as a link and keeps its state on refresh.
- Error pages, a 404 page, and lazy-loaded routes with a progress bar
- Types generated with GraphQL Code Generator
- Forms with `@mantine/form`. A field doesn't validate until you leave it or submit.
- Responsive layout for desktops, tablets, and smartphones
- Tests: Vitest and Testing Library with MSW, plus a Playwright test that signs up, adds to cart, checks out, and tracks the order on the live API

**Backend**
- Node.js, Express, TypeScript, GraphQL, Prisma
- Resolvers split by area (auth, products, cart, orders, user). Orders are created in one transaction.
- JWT auth, bcrypt passwords, and input validation
- Google sign-in: the backend verifies Google's ID token and issues its own JWT
- Password reset emails through Resend
- Tests with Vitest

**Infrastructure**
- PostgreSQL on Aiven, API on Render, web client on Vercel, and images on Cloudinary
- One GraphQL schema: the backend exports it and both clients generate their types from it
- GitHub Actions runs the backend, Flutter, and web tests, the Playwright test, and a check that generated types are up to date. It deploys the backend to Render when the backend changes, and Vercel deploys the web client when the web client changes.

## Features

- Sign up with email, password, and a phone code, or with Google. Password reset by email.
- Edit your profile, change your password, upload a profile picture, and set notification preferences
- Saved addresses and cards, each with a default
- Product categories, search, and filters (price, rating, discount, locally sourced, and pesticide-free)
- Cart and favorites update instantly and roll back if the server rejects the change. Removing the last unit of an item asks first, and mobile has swipe to delete.
- Checkout fills in your default address and card
- Order history with a 5-stage status timeline
- Product reviews and ratings

## Project Structure

```
backend/          Express + GraphQL API, Prisma schema, seed data, API tests
mobile_frontend/  Flutter app (features/<name>/{data,domain,presentation})
web_frontend/     React app (features/<name>/ with pages + api slice; shared components/, hooks/, lib/)
```

## Setup

### 1. Backend

Create `backend/.env` with `DATABASE_URL`, `JWT_SECRET`, and `RESEND_API_KEY`. The database connection is verified with Aiven's CA certificate in `backend/ca.pem`.

```bash
cd backend
npm install
npx prisma db push
npx tsx prisma/seed.ts
npm run dev
```

### 2. Mobile

```bash
cd mobile_frontend
flutter pub get
flutter run
```

### 3. Web

```bash
cd web_frontend
npm install
cp .env.example .env      # VITE_API_URL, the deployed API by default
npm run codegen           # generate types from the backend schema
npm run dev
```

After changing the GraphQL schema, run `npm run schema:export` in `backend/`, then `npm run codegen` in `web_frontend/` and `dart run build_runner build` in `mobile_frontend/`.

Web tests (Node 22 or newer):

```bash
npm test                          # unit and component tests
npx playwright install chromium   # once, before the first end-to-end run
npm run test:e2e                  # end-to-end test in a real browser
```

The end-to-end test creates a new `e2e+<timestamp>@example.com` account on whatever API `VITE_API_URL` points to, so it can run any number of times.

## Notes

- JWTs expire after one day. There are no refresh tokens.
- There's no SMS. The verification code is always 123456, and both apps say so on screen.
- Search history is stored on the device and cleared on sign-out.
- Addresses and cards added at checkout are saved to the account. Neither client deletes them, since orders reference them.
- Order tracking is simulated. An order moves one stage per day on Standard, every 6 hours on Next Day, and every 15 minutes on 1-Hour. The backend fills in the stages that are due whenever orders are read, so there's no background job.
- Payments are simulated. Stripe doesn't support accounts in Jordan, so saved cards store a placeholder payment ID. The CVV is never stored or sent, same as a real Stripe setup.
- Password reset emails use Resend's test sender, which only delivers to the Resend account owner until a domain is verified.
