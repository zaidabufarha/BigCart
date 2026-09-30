import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:big_cart/shell/main_shell.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:big_cart/features/auth/presentation/pages/login_page.dart';
import 'package:big_cart/features/auth/presentation/pages/sign_up_page.dart';
import 'package:big_cart/core/widgets/google_sign_in_button.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/core/widgets/top_bar_shade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  //stateless because there's no input to validate
  @override
  Widget build(BuildContext context) {
    void onClick() {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: ((context) => SignUpPage())));
    }

    // Google sign-in happens right here, so this page reacts to it the way
    // the login page reacts to a password login
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (user) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: ((context) => const MainShell())),
              (route) => false,
            );
          },
          error: (errorMessage) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(errorMessage)));
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: WidgetStateColor.transparent,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Welcome',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            SizedBox.expand(
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 300.h,
                    top: 0,
                    child: Image.asset(
                      'assets/woman_cart.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    height: 350.h,
                    bottom: 0.h,
                    child: Container(
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundSecondary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10.h,
                        children: [
                          Text(
                            'Welcome',
                            style: Fonts.titleBold(
                              size: 20,
                            ).copyWith(color: AppColors.textPrimary),
                          ),
                          Text(
                            'Fresh groceries, delivered fast. Sign in or create an account to start shopping.',
                            style: Fonts.paragraphRegular(size: 12).copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) => GoogleSignInButton(
                              () => context
                                  .read<AuthCubit>()
                                  .attemptGoogleSignIn(),
                              isLoading: state.maybeWhen(
                                loading: () => true,
                                orElse: () => false,
                              ),
                            ),
                          ),
                          GreenGradientButton.icon(
                            onClick,
                            'Create an account',
                            icon: Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: ((ctx) => LoginPage()),
                                  ),
                                );
                              },
                              child: Text.rich(
                                TextSpan(
                                  // same format on welcome, login and signup
                                  text: 'Already have an account? ',
                                  style: Fonts.label(size: 15).copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Login',
                                      style: Fonts.label(size: 15).copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const TopBarShade(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
