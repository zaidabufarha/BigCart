import 'package:big_cart/core/colors.dart';
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:big_cart/features/auth/presentation/pages/splash_screen.dart';
import 'package:big_cart/features/auth/presentation/pages/welcome_page.dart';
import 'package:big_cart/shell/main_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The app's first screen, shown only while it checks the saved session:
/// signed in → the shop, first time on this device → the welcome slides,
/// otherwise → the welcome page with sign-in options.
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    context.read<AuthCubit>().checkIfLoggedIn();
    super.initState();
  }

  void _goTo(Widget page) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        // no slide-in: the app should just open on the right screen
        pageBuilder: (context, _, _) => page,
        transitionDuration: Duration.zero,
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (_) => _goTo(const MainShell()),
          signedOut: (isFirstTime) => _goTo(
            isFirstTime ? const SplashScreen(0) : const WelcomePage(),
          ),
        );
      },
      child: const Scaffold(backgroundColor: AppColors.backgroundPrimary),
    );
  }
}
