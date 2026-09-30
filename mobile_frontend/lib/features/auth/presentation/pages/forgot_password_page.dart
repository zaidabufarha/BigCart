import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/validators.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordPageState();
  }
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  bool isValid = false;
  String? email;

  @override
  Widget build(BuildContext context) {
    void onClick() {
      isValid = formKey.currentState!.validate();
      if (isValid) {
        formKey.currentState!.save();
        context.read<AuthCubit>().userForgotPassword(email!);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Temporary password sent! Check your inbox.'),
            backgroundColor: AppColors.primary,
          ),
        );
        Navigator.of(context).pop();
      }
    }

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
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
        backgroundColor: AppColors.backgroundSecondary,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: WidgetStateColor.transparent,
          // dark on this light page; the white bar is for the photo pages
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textPrimary,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Password Recovery',
            style: TextStyle(color: AppColors.textPrimary),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              spacing: 30.h,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Forgot Password',
                  style: Fonts.titleBold(size: 25),
                ),
                Text(
                  "We'll email you a temporary password.",
                  style: Fonts.paragraphRegular(),
                  textAlign: TextAlign.center,
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
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
                      email = newValue?.trim();
                    },
                  ),
                ),
                GreenGradientButton(onClick, 'Next'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
