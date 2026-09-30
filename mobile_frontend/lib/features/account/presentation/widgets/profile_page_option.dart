import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:big_cart/features/auth/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ProfilePageOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget? destination;
  final bool signOut;

  /// Instead of opening [destination]: for options that switch the shell's
  /// tab (My Favorites) rather than push a page.
  final VoidCallback? onTap;
  const ProfilePageOption({
    super.key,
    required this.icon,
    required this.text,
    this.destination,
    this.signOut = false,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.primaryDark,
      onTap: () async {
        if (onTap != null) {
          onTap!();
          return;
        }
        if (signOut) {
          await context.read<AuthCubit>().attemptSignOut();
          if (!context.mounted) return;
          Navigator.pushAndRemoveUntil(
            context,
            // not the slides again: this device has been signed in before
            MaterialPageRoute(builder: (context) => const WelcomePage()),
            (route) => false,
          );
          return;
        }
        final page = destination;
        if (page == null) return;
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: ((context) => page)));
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 20.w,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: AppColors.primaryDark,
                size: 30.r,
              ),
              Text(
                text,
                style: Fonts.titleBold(size: 17),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.textSecondary,
            size: 30.r,
          ),
        ],
      ),
    );
  }
}
