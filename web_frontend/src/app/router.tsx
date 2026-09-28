import type { ComponentType } from "react";
import { createBrowserRouter, Navigate } from "react-router-dom";
import RootLayout from "../components/layout/RootLayout";
import PageLoader from "../components/PageLoader";
import HomePage from "../features/buy/pages/HomePage";
import OrderSuccessPage from "../features/buy/pages/checkout/OrderSuccessPage";
import ErrorPage from "../pages/ErrorPage";
import NotFoundPage from "../pages/NotFoundPage";

/**
 * Everything except the shell (RootLayout: top bar, nav, footer), the home
 * page and the error pages loads on first visit. Vite gives each import() its
 * own chunk, so a logged-out visitor on the home page never downloads account
 * or checkout code. The error pages stay in the main bundle because they're
 * what shows when a chunk fails to load.
 *
 * hydrateFallbackElement covers a direct visit (a shared link): the shell
 * renders and the page area shows a loader until the chunk arrives. Later
 * navigations keep the current page up instead, with the progress bar in
 * RootLayout.
 */
function page(load: () => Promise<{ default: ComponentType }>) {
  return {
    lazy: async () => ({ Component: (await load()).default }),
    hydrateFallbackElement: <PageLoader />,
  };
}

/** Dev only: a page that throws on render, to see the error boundary. */
function Crash(): never {
  throw new Error("Test crash from /__crash — this is the error boundary working.");
}

export const router = createBrowserRouter([
  {
    element: <RootLayout />,
    // last resort: the layout itself (nav, footer) threw — standalone error page
    errorElement: <ErrorPage />,
    children: [
      {
        // pathless boundary: a page error renders here, inside RootLayout's
        // Outlet, so nav and footer stay up around it
        errorElement: <ErrorPage />,
        children: [
          { index: true, element: <HomePage /> },
          { path: "favorites", element: <HomePage favorites /> },
          { path: "privacy", ...page(() => import("../pages/PrivacyPage")) },
          { path: "login", ...page(() => import("../features/auth/pages/LoginPage")) },
          { path: "signup", ...page(() => import("../features/auth/pages/SignUpPage")) },
          {
            path: "forgot-password",
            ...page(() => import("../features/auth/pages/ForgotPasswordPage")),
          },
          { path: "cart", ...page(() => import("../features/buy/pages/CartPage")) },
          {
            // nested layout: step indicator + order summary around the current step
            path: "checkout",
            ...page(() => import("../features/buy/CheckoutLayout")),
            children: [
              {
                index: true,
                element: <Navigate to="/checkout/delivery" replace />,
              },
              {
                path: "delivery",
                ...page(() => import("../features/buy/pages/checkout/DeliveryStep")),
              },
              {
                path: "address",
                ...page(() => import("../features/buy/pages/checkout/AddressStep")),
              },
              {
                path: "payment",
                ...page(() => import("../features/buy/pages/checkout/PaymentStep")),
              },
            ],
          },
          // outside the layout: the cart is empty by now, which would bounce it.
          // Eager (it's tiny): the end of checkout shouldn't wait on a chunk.
          { path: "checkout/success/:orderId", element: <OrderSuccessPage /> },
          {
            // nested layout: sidebar + <Outlet />, itself inside RootLayout's outlet
            path: "account",
            ...page(() => import("../features/account/AccountLayout")),
            children: [
              // the section list on phones; redirects to profile beside the sidebar
              { index: true, ...page(() => import("../features/account/pages/AccountIndexPage")) },
              { path: "profile", ...page(() => import("../features/account/pages/ProfilePage")) },
              { path: "orders", ...page(() => import("../features/account/pages/OrdersPage")) },
              {
                path: "orders/:id",
                ...page(() => import("../features/account/pages/TrackOrderPage")),
              },
              {
                path: "addresses",
                ...page(() => import("../features/account/pages/AddressesPage")),
              },
              { path: "cards", ...page(() => import("../features/account/pages/CardsPage")) },
              {
                path: "transactions",
                ...page(() => import("../features/account/pages/TransactionsPage")),
              },
              {
                path: "notifications",
                ...page(() => import("../features/account/pages/NotificationsPage")),
              },
            ],
          },
          { path: "product/:id", ...page(() => import("../features/buy/pages/ProductPage")) },
          {
            path: "product/:id/reviews",
            ...page(() => import("../features/buy/pages/ReviewsPage")),
          },
          {
            path: "product/:id/reviews/new",
            ...page(() => import("../features/buy/pages/WriteReviewPage")),
          },
          // dev only — stripped from the production build by the DEV check
          ...(import.meta.env.DEV ? [{ path: "__crash", element: <Crash /> }] : []),
          // anything that matched nothing above
          { path: "*", element: <NotFoundPage /> },
        ],
      },
    ],
  },
]);
