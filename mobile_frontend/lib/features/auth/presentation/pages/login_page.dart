import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:big_cart/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:big_cart/features/auth/presentation/pages/sign_up_page.dart';
import 'package:big_cart/features/auth/presentation/pages/welcome_page.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/core/widgets/lock_icon.dart';
import 'package:big_cart/core/widgets/top_bar_shade.dart';
import 'package:big_cart/shell/main_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool obscure = true;
  String inputEmail = '';
  String inputPassword = '';
  bool inputRemember = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().attemptGetSavedCredentials();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onClick() {
    bool isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
      context.read<AuthCubit>().attemptLogIn(
        inputEmail,
        inputPassword,
        inputRemember,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          loadedEmail: (email) {
            emailController.text = email;
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: WidgetStateColor.transparent,
          leading: IconButton(
            // back to Welcome, where "Continue with Google" lives
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const WelcomePage()),
              (route) => false,
            ),
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
                    bottom: 370.h,
                    top: 0,
                    child: Image.asset(
                      'assets/woman_freezer.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    height: 420.h,
                    bottom: 0.h,
                    child: Container(
                      padding: EdgeInsets.all(15.r),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundSecondary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8.h,
                          children: [
                            Text(
                              'Welcome back!',
                              style: Fonts.titleBold(
                                size: 20,
                              ).copyWith(color: AppColors.textPrimary),
                            ),
                            Text(
                              'Sign in to your account',
                              style: Fonts.paragraphRegular(size: 12).copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.mail_outline),
                                hint: Text(
                                  'Email Address',
                                  style: Fonts.paragraphRegular().copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Cannot be empty';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                inputEmail = newValue!.trim();
                              },
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: obscure,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const LockIcon(),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscure = !obscure;
                                    });
                                  },
                                  icon: Icon(
                                    (obscure)
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                // the design's placeholder is the dots themselves
                                hint: Text(
                                  '•••••••••',
                                  style: Fonts.paragraphRegular(size: 18)
                                      .copyWith(
                                        color: AppColors.textSecondary,
                                        letterSpacing: 4.w,
                                      ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Cannot be empty';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                inputPassword = newValue!;
                              },
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // the design's toggle is about 29x16; FittedBox
                                // shrinks the switch's real layout size, not
                                // just how it's drawn
                                Row(
                                  spacing: 8.w,
                                  children: [
                                    SizedBox(
                                      width: 38.w,
                                      height: 22.h,
                                      child: FittedBox(
                                        child: Switch(
                                          thumbColor: WidgetStateProperty.all(
                                            Colors.white,
                                          ),
                                          trackColor: WidgetStateProperty.all(
                                            (inputRemember)
                                                ? AppColors.primaryDark
                                                : AppColors.textSecondary,
                                          ),
                                          trackOutlineColor:
                                              WidgetStateColor.transparent,
                                          value: inputRemember,
                                          onChanged: (isChecked) {
                                            setState(() {
                                              inputRemember = isChecked;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Remember me',
                                      style: Fonts.paragraphRegular(),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Forgot password',
                                    style: Fonts.paragraphMedium().copyWith(
                                      color: AppColors.link,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            GreenGradientButton(
                              onClick,
                              'Login',
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => SignUpPage(),
                                    ),
                                  );
                                },
                                child: Text.rich(
                                  TextSpan(
                                    // same format on welcome, login and signup:
                                    // grey question, dark bold action
                                    text: 'Don\'t have an account? ',
                                    style: Fonts.label(size: 15).copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Sign up',
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
