import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/presentation/pages/track_order_page.dart';
import 'package:big_cart/shell/shell_tab_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

/// Shown after checkout, on top of home, so back returns to shopping.
class OrderSuccessPage extends StatelessWidget {
  final Order order;
  const OrderSuccessPage(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    void onClick() {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => TrackOrderPage(order)));
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        title: Text(
          'Order Success',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(80),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: AppColors.primaryDark,
                      size: 200.r,
                    ),
                    Text(
                      'Your order was successful!',
                      textAlign: TextAlign.center,
                      style: Fonts.titleBold(size: 30),
                    ),
                    Text(
                      'You will get a response within a few minutes.',
                      textAlign: TextAlign.center,
                      style: Fonts.paragraphRegular(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 10.h,
              children: [
                GreenGradientButton(onClick, 'Track order'),
                // the web page's second button: back to the shop's Home tab
                SizedBox(
                  width: double.infinity,
                  height: 60.h,
                  // the opposite of Track order: pale fill, dark text and a
                  // green border, like the web page's light button
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary.withValues(
                        alpha: 0.12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side: const BorderSide(color: AppColors.primary),
                      ),
                    ),
                    onPressed: () {
                      context.read<ShellTabCubit>().show(ShellTabCubit.home);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text(
                      'Continue shopping',
                      style: Fonts.titleBold(
                        size: 15,
                      ).copyWith(color: AppColors.primaryDark),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
