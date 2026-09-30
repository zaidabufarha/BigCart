import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/validators.dart';
import 'package:big_cart/features/auth/presentation/pages/login_page.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/core/widgets/lock_icon.dart';
import 'package:big_cart/core/widgets/top_bar_shade.dart';
import 'package:big_cart/features/auth/presentation/pages/verify_number_page.dart';
import 'package:big_cart/features/auth/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignUpPage();
  }
}

class _SignUpPage extends State<SignUpPage> {
  bool obscure = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    late String inputEmail;
    late String inputPassword;

    // Nothing is created yet: the verify page asks for the number, checks the
    // code, and only then makes the account
    void onClick() {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => VerifyNumberPage(
              inputEmail: inputEmail,
              inputPassword: inputPassword,
            )),
          ),
        );
      }
    }

    return Scaffold(
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
                  bottom: 350.h,
                  top: 0,
                  child: Image.asset(
                    'assets/woman_happy.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  // one field fewer now the number moved to its own page
                  height: 400.h,
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
                        spacing: 10.h,
                        children: [
                          Text(
                            'Create account',
                            style: Fonts.titleBold(
                              size: 20,
                            ).copyWith(color: AppColors.textPrimary),
                          ),
                          Text(
                            'Quickly create account',
                            style: Fonts.paragraphRegular(size: 12).copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          TextFormField(
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
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail,
                            onSaved: (newValue) {
                              inputEmail = newValue!.trim();
                            },
                          ),
                          TextFormField(
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
                              if (value.length < 8 || value.length > 72) {
                                return 'Password must be between 8 and 72 characters';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              inputPassword = newValue!;
                            },
                          ),
                          SizedBox(height: 4.h),
                          GreenGradientButton(onClick, 'Next'),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: ((context) => LoginPage()),
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
                ),
                const TopBarShade(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
