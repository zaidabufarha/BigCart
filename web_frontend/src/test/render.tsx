import { MantineProvider } from "@mantine/core";
import { render, type RenderOptions } from "@testing-library/react";
import type { ReactElement, ReactNode } from "react";
import { Provider } from "react-redux";
import { MemoryRouter } from "react-router-dom";
import { store } from "../app/store";
import { theme } from "../theme";

/** The same providers main.tsx wraps the app in, minus the real router. */
function Providers({ children }: { children: ReactNode }) {
  return (
    <Provider store={store}>
      {/* env="test" turns off Mantine's transitions and portals, which
          otherwise make popovers and menus awkward to assert on in jsdom */}
      <MantineProvider theme={theme} env="test">
        <MemoryRouter>{children}</MemoryRouter>
      </MantineProvider>
    </Provider>
  );
}

export function renderWithProviders(ui: ReactElement, options?: Omit<RenderOptions, "wrapper">) {
  return render(ui, { wrapper: Providers, ...options });
}

export * from "@testing-library/react";
