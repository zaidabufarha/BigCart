import { TextInput, type TextInputProps } from "@mantine/core";
import { CountrySelector, usePhoneInput } from "react-international-phone";
import type { FocusEvent, ReactNode } from "react";
import "react-international-phone/style.css";

type PhoneFieldProps = {
  // optional because getInputProps' return type widens value, even in controlled mode
  value?: string;
  onChange: (phone: string) => void;
  onBlur?: (event: FocusEvent<HTMLInputElement>) => void;
  error?: ReactNode;
} & Pick<TextInputProps, "size" | "label" | "placeholder" | "maw" | "disabled">;

/**
 * Phone input with a country picker, used by signup, the profile page and the address form.
 * Emits the full international number (e.g. +962791234567); pair it with
 * `validatePhone` from lib/phone so every form checks it the same way.
 * Defaults are signup's large style; the profile passes its own.
 */
function PhoneField({
  value,
  onChange,
  onBlur,
  error,
  size = "xl",
  label = "Phone",
  placeholder = "Enter your phone number",
  maw = 500,
  disabled,
}: PhoneFieldProps) {
  const { inputValue, country, setCountry, handlePhoneValueChange, inputRef } =
    usePhoneInput({
      defaultCountry: "jo",
      value: value ?? "",
      onChange: ({ phone }) => onChange(phone),
    });

  return (
    <TextInput
      size={size}
      w="100%"
      maw={maw}
      label={label}
      placeholder={placeholder}
      type="tel"
      value={inputValue}
      onChange={handlePhoneValueChange}
      onBlur={onBlur}
      error={error}
      disabled={disabled}
      ref={inputRef}
      leftSectionWidth={72}
      // Mantine's input section is z-index:1 and creates a stacking context, so the
      // country dropdown can't paint over later fields unless the section itself lifts
      styles={{ section: { zIndex: 5 } }}
      leftSectionPointerEvents="all"
      leftSection={
        <CountrySelector
          selectedCountry={country.iso2}
          onSelect={({ iso2 }) => setCountry(iso2)}
          disabled={disabled}
          buttonStyle={{ border: "none", background: "transparent" }}
          dropdownStyleProps={{ style: { zIndex: 300 } }}
        />
      }
    />
  );
}

export default PhoneField;
