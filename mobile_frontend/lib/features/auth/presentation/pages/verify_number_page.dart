import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:big_cart/shell/main_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pinput.dart';

/// The second half of sign up: the number (asked for once, here), then the
/// code. The account is created only after the code checks out.
class VerifyNumberPage extends StatefulWidget {
  final String inputEmail;
  final String inputPassword;
  const VerifyNumberPage({
    required this.inputEmail,
    required this.inputPassword,
    super.key,
  });
  @override
  State<StatefulWidget> createState() {
    return _VerifyNumberPageState();
  }
}

class _VerifyNumberPageState extends State<VerifyNumberPage> {
  bool otpSent = false;
  PhoneNumber? inputNumber;
  String inputOtp = '';
  final numberForm = GlobalKey<FormState>();
  // Jordan first, like the web client. One fixed value: the field reads it
  // once and would reset itself if it ever changed.
  static final _startCountry = PhoneNumber(isoCode: 'JO');
  @override
  Widget build(BuildContext context) {
    // No SMS is actually sent, so say what the code is
    void showCode() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Your code is 123456'),
          content: const Text(
            "SMS isn't set up yet, so no text will arrive. Enter 123456 to continue.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    void showMessage(String message) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }

    void onClick() {
      final number = inputNumber?.phoneNumber;
      if (!otpSent) {
        // shows the field's error in red instead of doing nothing
        if (!numberForm.currentState!.validate() || number == null) return;
        context.read<AuthCubit>().sendOtpToUser(number);
        setState(() {
          otpSent = true;
        });
        showCode();
      } else if (inputOtp.length < 6) {
        showMessage('Enter the 6-digit code');
      } else if (number != null) {
        context.read<AuthCubit>().verifyUserOtp(
          email: widget.inputEmail,
          otp: inputOtp,
          password: widget.inputPassword,
          number: number,
        );
      }
    }

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (user) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: ((context) => const MainShell())),
              (route) => false,
            );
          },
          error: showMessage,
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundSecondary,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: WidgetStateColor.transparent,
          leading: IconButton(
            // from the code back to the number, from the number back to sign up
            onPressed: () {
              if (otpSent) {
                setState(() {
                  otpSent = false;
                  inputOtp = '';
                });
              } else {
                Navigator.of(context).pop();
              }
            },
            // dark on this light page; the white bar is for the photo pages
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textPrimary,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Verify Number',
            style: TextStyle(color: AppColors.textPrimary),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              spacing: 20.h,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verify your number',
                  style: Fonts.titleBold(size: 25),
                ),
                Text(
                  (otpSent)
                      ? 'Enter your OTP code below'
                      : "We'll text a code to this number to finish creating your account.",
                  style: Fonts.paragraphRegular(),
                  textAlign: TextAlign.center,
                ),
                if (otpSent)
                  Pinput(
                    length: 6,
                    obscureText: true,
                    defaultPinTheme: PinTheme(
                      width: 60.w,
                      height: 60.h,
                      textStyle: Fonts.titleBold(size: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                    onChanged: (value) {
                      inputOtp = value;
                    },
                  ),
                // Hidden, not removed, during the code step: it keeps the
                // number and country itself, so going back shows them as
                // they were.
                Visibility(
                  visible: !otpSent,
                  maintainState: true,
                  child: Form(
                    key: numberForm,
                    child: InternationalPhoneNumberInput(
                      initialValue: _startCountry,
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      onInputChanged: (number) {
                        inputNumber = number;
                      },
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      errorMessage: 'Enter a valid phone number',
                    ),
                  ),
                ),
                (otpSent)
                    ? Text(
                        'Didn\'t receive a code?',
                        style: Fonts.paragraphMedium(),
                      )
                    : SizedBox(
                        height: 0,
                      ),
                (otpSent)
                    ? GestureDetector(
                        onTap: showCode,
                        child: Text(
                          'Resend a new code',
                          style: Fonts.paragraphMedium().copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 0,
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
