import { expect, test } from "@playwright/test";

// A fresh account per run: the timestamp keeps emails unique, so the suite can
// be re-run forever without "email already in use".
const stamp = Date.now();
const user = {
  email: `e2e+${stamp}@example.com`,
  phone: "791234567", // typed after the preselected +962, so it reads +962791234567
  password: "e2e-password-123",
};

test("sign up, add to cart, check out, track the order", async ({ page }) => {
  // --- sign up, with the simulated OTP -------------------------------------
  await page.goto("/signup");
  await page.getByLabel("Email").fill(user.email);
  // the phone field formats as you type, so it needs real keystrokes, not fill()
  await page.getByLabel("Phone").pressSequentially(user.phone);
  await page.getByLabel("Password", { exact: true }).fill(user.password);
  await page.getByRole("button", { name: "Sign up", exact: true }).click();

  await expect(page.getByText("Confirm it's You")).toBeVisible();
  await page.locator('input[inputmode="numeric"]').first().pressSequentially("123456");
  await page.getByRole("button", { name: "Verify" }).click();

  // signed in and back on the storefront
  await expect(page).toHaveURL("/");
  await expect(page.getByRole("heading", { name: "Popular Products" })).toBeVisible();

  // --- add the first product ---------------------------------------------
  await page.getByRole("button", { name: "Add to cart" }).first().click();
  // the strip becomes a stepper; the navbar badge shows 1
  await expect(page.getByRole("button", { name: "Increase quantity" }).first()).toBeVisible();
  await expect(page.getByRole("link", { name: /^Cart, 1 item/ })).toBeVisible();

  // --- cart ----------------------------------------------------------------
  await page.getByRole("link", { name: /^Cart, 1 item/ }).click();
  await expect(page.getByRole("heading", { name: /Shopping Cart/ })).toBeVisible();
  await page.getByRole("link", { name: "Checkout" }).click();

  // --- delivery ------------------------------------------------------------
  await expect(page).toHaveURL(/\/checkout\/delivery/);
  await page.getByRole("button", { name: "Next" }).click();

  // --- address: a new account has none, so the form is already open -------
  await expect(page).toHaveURL(/\/checkout\/address/);
  await page.getByLabel("Name", { exact: true }).fill("E2E Tester");
  await page.getByRole("textbox", { name: "Address", exact: true }).fill("1 Test Street");
  // role and exact names throughout: the phone field's country picker has its
  // own "Country selector" button and options like "Vatican City +39"
  await page.getByRole("textbox", { name: "City" }).fill("Amman");
  await page.getByLabel("Zip code").fill("11118");
  await page.getByRole("combobox", { name: "Country", exact: true }).fill("Jordan");
  await page.getByRole("option", { name: "Jordan", exact: true }).click();
  await page.getByLabel("Phone number").pressSequentially(user.phone);
  await page.getByRole("button", { name: "Save" }).click();

  // saved and selected; the locked details view shows it
  await expect(page.getByText("Delivery details")).toBeVisible();
  await page.getByRole("button", { name: "Next" }).click();

  // --- payment: same story with a card -------------------------------------
  await expect(page).toHaveURL(/\/checkout\/payment/);
  await page.getByLabel("Name on the card").fill("E2E Tester");
  await page.getByLabel("Card number").fill("4242424242424242");
  await page.getByLabel("Expiry").fill("12/30");
  await page.getByRole("button", { name: "Save" }).click();
  await expect(page.getByText("Card details")).toBeVisible();

  await page.getByRole("button", { name: "Place order" }).click();

  // --- success and tracking ------------------------------------------------
  await expect(page).toHaveURL(/\/checkout\/success\/\d+/);
  await expect(page.getByRole("heading", { name: "Order placed!" })).toBeVisible();

  await page.getByRole("link", { name: "Track order" }).click();
  await expect(page).toHaveURL(/\/account\/orders\/\d+/);
  await expect(page.getByRole("heading", { name: "Track Order" })).toBeVisible();
  await expect(page.getByText("Order Placed")).toBeVisible();

  // the cart is empty again
  await page.goto("/cart");
  await expect(page.getByRole("heading", { name: "Your cart is empty!" })).toBeVisible();
});
