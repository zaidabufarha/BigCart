import { isValidPhoneNumber } from "libphonenumber-js";

/** The one phone check, for signup, the profile and addresses: a real number for its country. */
export const validatePhone = (value: string) =>
  isValidPhoneNumber(value) ? null : "Enter a valid phone number";
