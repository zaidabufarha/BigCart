import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';

/// One payment method tile at checkout: a square, sized small enough that
/// the pay button still fits without scrolling.
class PaymentCard extends StatelessWidget {
  final String path;
  final String text;
  final bool selected;
  final VoidCallback onTap;
  const PaymentCard({
    required this.path,
    required this.text,
    required this.onTap,
    this.selected = false,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 88.w,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundPrimary,
            // the method in use gets the green outline
            border: Border.all(
              color: selected ? AppColors.primary : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12.h,
            children: [
              SvgPicture.asset(
                path,
                width: 20.w,
                height: 20.w,
                fit: BoxFit.contain,
              ),
              Text(
                text,
                style: Fonts.label(size: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
