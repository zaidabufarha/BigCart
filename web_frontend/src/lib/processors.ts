import mastercard from "../assets/mastercard.png";
import paypal from "../assets/paypal.png";
import visa from "../assets/visa.png";

// Card processors are stored as the Flutter enum names: visa | mastercard | paypal.
// Used by the cards page and by transactions (payment_method is the same value).
export const PROCESSOR_LOGOS: Record<string, string> = { visa, mastercard, paypal };

export const PROCESSOR_LABELS: Record<string, string> = {
  visa: "Visa Card",
  mastercard: "Master Card",
  paypal: "PayPal",
};

/**
 * The card brand from the number, the way a real checkout does it: Visa
 * numbers start with 4, everything else is treated as Mastercard. Deliberately
 * lenient — nobody trying the site should be told their made-up number is the
 * wrong brand. PayPal can't be added (it isn't a card), though older PayPal
 * rows still display through the maps above. Null until a digit is typed.
 */
export function detectProcessor(number: string): "visa" | "mastercard" | null {
  const d = number.replace(/\D/g, "");
  if (d === "") return null;
  return d.startsWith("4") ? "visa" : "mastercard";
}
