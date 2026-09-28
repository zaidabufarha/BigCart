import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';

/// "Continue with Google": the same white button on the welcome, login and
/// signup screens. Each screen decides what pressing it does.
class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1.r),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextButton.icon(
        icon: SvgPicture.asset(
          'assets/google_logo.svg',
          width: 20.w,
          height: 20.h,
        ),
        onPressed: onPressed,
        label: Text(
          ' Continue with Google',
          style: Fonts.titleBold(
            size: 20,
          ).copyWith(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
