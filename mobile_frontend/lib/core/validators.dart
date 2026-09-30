// Form checks shared by every screen that asks for the same thing, so the
// address page and checkout can't drift apart. Phone numbers are checked by
// PhoneField itself.

/// Something@something.something, with no spaces.
String? validateEmail(String? value) {
  final v = value?.trim() ?? '';
  if (v.isEmpty) return 'Cannot be empty';
  if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v)) {
    return 'Enter a valid email';
  }
  return null;
}

/// 13–19 digits, the range every card network uses; spaces are ignored.
String? validateCardNumber(String? value) {
  final digits = (value ?? '').replaceAll(' ', '');
  if (digits.isEmpty) return 'Cannot be empty';
  if (!RegExp(r'^\d{13,19}$').hasMatch(digits)) {
    return 'Enter a 13–19 digit card number';
  }
  return null;
}

/// 3 digits, or 4 on American Express.
String? validateCvv(String? value) {
  final v = value?.trim() ?? '';
  if (v.isEmpty) return 'Cannot be empty';
  if (!RegExp(r'^\d{3,4}$').hasMatch(v)) return 'Enter the 3 or 4 digit code';
  return null;
}

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
