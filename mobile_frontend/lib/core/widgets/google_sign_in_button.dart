import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';

/// "Continue with Google" on the welcome screen: white, the same size as the
/// green button, logo at the left edge and the label centred.
class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  /// Google's picker plus the backend can take several seconds; a spinner
  /// shows it's working and the button ignores taps meanwhile.
  final bool isLoading;

  const GoogleSignInButton(this.onPressed, {this.isLoading = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
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
                  color: AppColors.primaryDark,
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: SvgPicture.asset(
                        'assets/google_logo.svg',
                        width: 20.w,
                        height: 20.w,
                      ),
                    ),
                  ),
                  Text(
                    'Continue with Google',
                    style: Fonts.titleBold(
                      size: 15,
                    ).copyWith(color: AppColors.textPrimary),
                  ),
                ],
              ),
      ),
    );
  }
}
