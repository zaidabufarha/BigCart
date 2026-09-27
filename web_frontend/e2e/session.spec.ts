import { expect, test } from "@playwright/test";

// A token the server won't accept (expired, or just garbage) must not leave the
// app looking signed in. The backend answers "Not authorized", the base query
// signs out, and the account area's login gate redirects.
test("a rejected token signs you out", async ({ page }) => {
  await page.goto("/");
  await page.evaluate(() => localStorage.setItem("token", "not.a.real.jwt"));

  await page.goto("/account/orders");

  await expect(page).toHaveURL(/\/login/);
  expect(await page.evaluate(() => localStorage.getItem("token"))).toBeNull();
});
