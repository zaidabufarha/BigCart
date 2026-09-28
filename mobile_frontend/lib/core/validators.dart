// Form checks shared by every screen that asks for the same thing, so the
// address page and checkout can't drift apart. Phone numbers are checked by
// PhoneField itself.

/// Postal codes worldwide run 3–10 characters of letters, digits, spaces and
/// hyphens ("100", "SW1A 1AA", "12345-6789"). Loose on purpose: it only
/// catches obvious typos, not every country's format.
String? validateZip(String? value) {
  final v = value?.trim() ?? '';
  if (v.isEmpty) return 'Cannot be empty';
  if (!RegExp(r'^[A-Za-z0-9][A-Za-z0-9 -]{1,8}[A-Za-z0-9]$').hasMatch(v)) {
    return 'Enter a valid zip code';
  }
  return null;
}

/// A card expiry as MM/YY, the format ExpiryDateFormatter types out.
String? validateExpiry(String? value) {
  final v = value?.trim() ?? '';
  if (v.isEmpty) return 'Cannot be empty';
  if (!RegExp(r'^(0[1-9]|1[0-2])/\d{2}$').hasMatch(v)) return 'Use MM/YY';
  return null;
}
