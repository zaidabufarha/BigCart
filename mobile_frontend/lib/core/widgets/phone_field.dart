import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

/// Phone input with a country picker in the field, styled like the app's
/// other filled fields. Same package as the verify number page, so it checks
/// the number is real for the chosen country. Reports the full international
/// number (e.g. +962791234567) and fails form validation until it's valid.
///
/// [initialNumber] fills it with a saved number (the profile, an address
/// being edited); its country is worked out from the number itself.
class PhoneField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? initialNumber;
  final Color fillColor;

  const PhoneField({
    required this.onChanged,
    this.initialNumber,
    this.fillColor = AppColors.backgroundPrimary,
    super.key,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  // Jordan first, like the web client
  static const _defaultIso = 'JO';
  late final Future<PhoneNumber> _initial = _resolveInitial();

  Future<PhoneNumber> _resolveInitial() async {
    final saved = widget.initialNumber?.trim() ?? '';
    if (saved.isEmpty) return PhoneNumber(isoCode: _defaultIso);
    try {
      // a local number without a +code is read as Jordanian
      return await PhoneNumber.getRegionInfoFromPhoneNumber(saved, _defaultIso);
    } catch (_) {
      return PhoneNumber(isoCode: _defaultIso);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PhoneNumber>(
      future: _initial,
      builder: (context, snapshot) {
        // the input reads its initial value once, so wait for it
        if (!snapshot.hasData) return SizedBox(height: 56.h);
        return InternationalPhoneNumberInput(
          initialValue: snapshot.data,
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            setSelectorButtonAsPrefixIcon: true,
            leadingPadding: 12.w,
          ),
          onInputChanged: (number) =>
              widget.onChanged(number.phoneNumber ?? ''),
          errorMessage: 'Enter a valid phone number',
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectorTextStyle: Fonts.paragraphRegular(),
          textStyle: Fonts.paragraphRegular(),
          inputDecoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hint: Text('Phone number', style: Fonts.paragraphRegular()),
          ),
        );
      },
    );
  }
}
