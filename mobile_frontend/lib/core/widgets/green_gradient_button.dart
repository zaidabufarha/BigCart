import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

/// The app's main button: the green gradient, full width, 60 tall like the
/// Figma "primaryButton". With an icon, the icon sits at the left edge and
/// the label stays centred.
class GreenGradientButton extends StatelessWidget {
  final VoidCallback onClick;
  final Icon? icon;
  final String text;
  final bool isLoading;

  const GreenGradientButton(
    this.onClick,
    this.text, {
    this.isLoading = false,
    super.key,
  }) : icon = null;

  const GreenGradientButton.icon(
    this.onClick,
    this.text, {
    this.icon,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: AlignmentGeometry.bottomLeft,
          end: AlignmentGeometry.topRight,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextButton(
        onPressed: isLoading ? null : onClick,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 22.h,
                width: 22.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  if (icon != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: icon,
                      ),
                    ),
                  Text(
                    text,
                    style: Fonts.titleBold(
                      size: 15,
                    ).copyWith(color: Colors.white),
                  ),
                ],
              ),
      ),
    );
  }
}
