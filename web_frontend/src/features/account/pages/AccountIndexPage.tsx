import { useMediaQuery } from "@mantine/hooks";
import { Navigate } from "react-router-dom";

/**
 * /account itself. With the sidebar showing (md and up) there's nothing to
 * put beside it, so it goes straight to the profile. On a phone the sidebar
 * IS the page — a list you pick a section from, like a native settings
 * screen — and AccountLayout renders it in place of the outlet.
 */
function AccountIndexPage() {
  // read synchronously so the desktop redirect happens on the first render
  const wide = useMediaQuery("(min-width: 62em)", true, { getInitialValueInEffect: false });
  return wide ? <Navigate to="/account/profile" replace /> : null;
}

export default AccountIndexPage;
