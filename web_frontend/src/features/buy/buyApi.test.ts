import { describe, expect, it } from "vitest";
import { mockGraphql } from "../../test/msw";
import { store } from "../../app/store";
import { buyApi } from "./buyApi";

const product = {
  id: "7",
  name: "Gold Pineapple",
  image_path: "p.png",
  amount: "1 piece",
  description: "",
  discount: 0,
  price: 9.9,
  is_new: false,
  is_favorite: false,
  color: "4294900199",
  rating: 0,
  free_shipping: true,
  same_day_delivery: true,
  category: { id: "2", name: "Fruits", image_path: "f.png", color: "4294961637" },
};

const cartQuantity = () =>
  buyApi.endpoints.getCart.select()(store.getState()).data?.find((i) => i.id === "c1")?.quantity;

describe("optimistic cart updates", () => {
  it("applies a quantity change immediately and rolls it back when the server rejects it", async () => {
    mockGraphql({ data: { cart: [{ id: "c1", quantity: 2, product }] } });
    await store.dispatch(buyApi.endpoints.getCart.initiate());
    expect(cartQuantity()).toBe(2);

    // the server will refuse this one
    mockGraphql({ data: null, errors: [{ message: "Not enough stock" }] });
    const pending = store.dispatch(buyApi.endpoints.updateCartItem.initiate({ id: "c1", quantity: 5 }));

    // before the response: the cache already shows the new number
    expect(cartQuantity()).toBe(5);

    await pending;

    // after the failure: back to what the server last confirmed
    expect(cartQuantity()).toBe(2);
  });

  it("keeps the change when the server accepts it", async () => {
    mockGraphql({ data: { cart: [{ id: "c1", quantity: 2, product }] } });
    await store.dispatch(buyApi.endpoints.getCart.initiate());

    mockGraphql({ data: { updateCartItem: { id: "c1" } } });
    await store.dispatch(buyApi.endpoints.updateCartItem.initiate({ id: "c1", quantity: 3 }));

    expect(cartQuantity()).toBe(3);
  });

  it("removes a row optimistically and restores it on failure", async () => {
    mockGraphql({ data: { cart: [{ id: "c1", quantity: 1, product }] } });
    await store.dispatch(buyApi.endpoints.getCart.initiate());

    mockGraphql({ data: null, errors: [{ message: "nope" }] });
    const pending = store.dispatch(buyApi.endpoints.removeFromCart.initiate({ id: "c1" }));
    expect(cartQuantity()).toBeUndefined();

    await pending;
    expect(cartQuantity()).toBe(1);
  });
});
