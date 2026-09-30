// Shipping methods by the names both clients send. The clients show these
// prices at checkout and the backend charges them, so a price change here
// needs the same change in web_frontend/src/features/buy/shipping.ts and the
// Flutter shipping step.
//
// `step` is the time between one order stage and the next (see
// order-progress.ts): four steps take an order from placed to delivered.
const MINUTE = 60 * 1000;
const HOUR = 60 * MINUTE;

export const SHIPPING_METHODS: Record<string, { price: number; step: number }> = {
    'Standard Delivery': { price: 3, step: 24 * HOUR },
    'Next Day Delivery': { price: 5, step: 6 * HOUR },
    '1-Hour Delivery': { price: 10, step: 15 * MINUTE },
};

export const DEFAULT_SHIPPING_METHOD = 'Standard Delivery';

// Older orders say "Standard" or "Nominated Delivery", which no longer
// exist; they move at Standard's pace.
export function stepFor(method: string): number {
    return (SHIPPING_METHODS[method] ?? SHIPPING_METHODS[DEFAULT_SHIPPING_METHOD]).step;
}
