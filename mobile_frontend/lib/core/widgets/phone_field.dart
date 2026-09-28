import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

/// Phone input with a country picker in the field, styled like the app's
/// other filled fields. Same package as the verify number page, so it checks
/// the number is real for the chosen country. Reports the full international
/// number (e.g. +962791234567) and fails form validation until it's valid.
class PhoneField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const PhoneField({required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      // Jordan first, like the web client
      initialValue: PhoneNumber(isoCode: 'JO'),
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: 12.w,
      ),
      onInputChanged: (number) => onChanged(number.phoneNumber ?? ''),
      errorMessage: 'Enter a valid phone number',
      autoValidateMode: AutovalidateMode.onUserInteraction,
      selectorTextStyle: Fonts.paragraphRegular(),
      textStyle: Fonts.paragraphRegular(),
      inputDecoration: InputDecoration(
        filled: true,
        fillColor: AppColors.backgroundPrimary,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        hint: Text('Phone number', style: Fonts.paragraphRegular()),
      ),
    );
  }
}
