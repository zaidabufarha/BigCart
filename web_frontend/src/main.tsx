import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { MantineProvider } from "@mantine/core";
import { RouterProvider } from "react-router-dom";
import "@mantine/core/styles.css";
import "@mantine/nprogress/styles.css";
import "./index.css";
import { theme } from "./theme.ts";
import { router } from "./app/router.tsx";

import { store } from "./app/store.ts";
import { Provider } from "react-redux";
import { GoogleOAuthProvider } from "@react-oauth/google";
import { GOOGLE_CLIENT_ID } from "./lib/google.ts";

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <MantineProvider
      theme={theme}
      defaultColorScheme="light"
      forceColorScheme="light"
    >
      <Provider store={store}>
        {/* loads Google's sign-in script once, for the Google buttons; English
            to match the site (Google otherwise picks by browser and region) */}
        <GoogleOAuthProvider clientId={GOOGLE_CLIENT_ID} locale="en">
          <RouterProvider router={router} />
        </GoogleOAuthProvider>
      </Provider>
    </MantineProvider>
  </StrictMode>,
);
