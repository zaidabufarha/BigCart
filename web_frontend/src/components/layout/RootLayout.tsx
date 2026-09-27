import { useEffect } from "react";
import { Outlet, ScrollRestoration, useNavigation } from "react-router-dom";
import { Box, useMantineTheme } from "@mantine/core";
import { NavigationProgress, nprogress } from "@mantine/nprogress";
import TopBar from "./TopBar";
import NavBar from "./NavBar";
import Footer from "./Footer";

/**
 * The thin bar across the top of the window while a lazily loaded page's code
 * is on its way. There are no route loaders, so "loading" only ever means that.
 * Darkest green so it reads against both the green top bar and the white nav.
 */
function RouteProgress() {
  const { state } = useNavigation();

  useEffect(() => {
    if (state === "loading") nprogress.start();
    else nprogress.complete();
  }, [state]);

  return <NavigationProgress color="green.9" size={3} />;
}

function RootLayout() {
  const theme = useMantineTheme();

  return (
    <>
      {/* new pages open at the top; back/forward return to where you were.
          In-page URL updates (filters, checkout selections) opt out with
          preventScrollReset. */}
      <ScrollRestoration />
      <RouteProgress />
      <TopBar />
      <NavBar />
      <Box bg={theme.other.bgSecondary} mih={"25vh"}>
        <Outlet />
      </Box>
      <Footer />
    </>
  );
}

export default RootLayout;
