import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/di/injection.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/cards_cubit.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/cubit/address_cubit.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/orders_cubit.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/transactions_cubit.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/user_cubit.dart';
import 'package:big_cart/features/auth/presentation/cubit/cubit/auth_cubit.dart';
import 'package:big_cart/shell/start_screen.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/reviews_cubit.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AddressCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CardsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<OrdersCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<TransactionsCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<UserCubit>(),
        ),
        BlocProvider(create: (context) => getIt<ShopCubit>()),
        BlocProvider(create: (context) => getIt<ReviewsCubit>()),
        BlocProvider(create: (context) => getIt<CartCubit>()),
      ],
      // Every .w / .h / .r / .sp in the app scales against this size: the
      // Figma frames are 414x896, so a number copied from Figma means the same
      // thing on any phone. Without this the package falls back to its own
      // 360x690 default and nothing was scaled to the design.
      child: ScreenUtilPlusInit(
        designSize: const Size(414, 896),
        builder: (context, child) => MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          // every text field's leading and trailing icons use the same grey
          // as the password eye, instead of each field setting it
          theme: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
              prefixIconColor: AppColors.textSecondary,
              suffixIconColor: AppColors.textSecondary,
            ),
          ),
          home: const StartScreen(),
        ),
      ),
    );
  }
}
