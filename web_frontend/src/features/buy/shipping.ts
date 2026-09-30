/**
 * Shipping methods. `value` is the URL slug, `label` is the string stored on
 * the order (Flutter's names, so both clients write the same thing).
 *
 * The backend charges these prices (backend/src/graphql/shipping.ts) and adds
 * them to the order's total, so the two lists must match.
 */
export type ShippingMethod = {
  value: string;
  label: string;
  price: number;
  description: string;
};

export const SHIPPING_METHODS: ShippingMethod[] = [
  {
    value: "standard",
    label: "Standard Delivery",
    price: 3,
    description: "Delivered within 4 days.",
  },
  {
    value: "next-day",
    label: "Next Day Delivery",
    price: 5,
    description: "Delivered within 24 hours.",
  },
  {
    value: "1-hour",
    label: "1-Hour Delivery",
    price: 10,
    description: "Delivered within an hour.",
  },
];

export const DEFAULT_SHIPPING = SHIPPING_METHODS[0];

export function findShipping(value: string | null | undefined): ShippingMethod | undefined {
  return SHIPPING_METHODS.find((m) => m.value === value);
}
