import 'package:big_cart/core/expiry_date_formatter.dart';
import 'package:big_cart/core/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('validateZip', () {
    test('accepts short, long and lettered codes', () {
      expect(validateZip('100'), isNull);
      expect(validateZip('11118'), isNull);
      expect(validateZip('SW1A 1AA'), isNull);
      expect(validateZip('12345-6789'), isNull);
    });

    test('rejects empty, too short, too long and symbols', () {
      expect(validateZip(''), 'Cannot be empty');
      expect(validateZip('12'), 'Enter a valid zip code');
      expect(validateZip('12345678901'), 'Enter a valid zip code');
      expect(validateZip('12#45'), 'Enter a valid zip code');
    });
  });

  group('validateExpiry', () {
    test('needs a real month as MM/YY', () {
      expect(validateExpiry('09/32'), isNull);
      expect(validateExpiry('13/32'), 'Use MM/YY');
      expect(validateExpiry('0932'), 'Use MM/YY');
    });
  });

  group('ExpiryDateFormatter', () {
    String type(String old, String text) => ExpiryDateFormatter()
        .formatEditUpdate(
          TextEditingValue(text: old),
          TextEditingValue(text: text),
        )
        .text;

    test('adds the slash with the third digit', () {
      expect(type('', '0'), '0');
      expect(type('0', '09'), '09');
      expect(type('09', '093'), '09/3');
      expect(type('09/3', '09/32'), '09/32');
    });

    test('stops at four digits and drops non-digits', () {
      expect(type('09/32', '09/321'), '09/32');
      expect(type('', '09a32'), '09/32');
    });

    test('backspace past the slash removes it', () {
      expect(type('09/3', '09/'), '09');
    });
  });
}
