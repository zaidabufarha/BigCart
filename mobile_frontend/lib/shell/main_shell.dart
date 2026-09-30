import 'package:big_cart/core/colors.dart';
import 'package:big_cart/features/account/presentation/pages/profile_page.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/favorites_cubit.dart';
import 'package:big_cart/features/buy/presentation/pages/cart_page.dart';
import 'package:big_cart/features/buy/presentation/pages/home_page.dart';
import 'package:big_cart/features/buy/presentation/widgets/remove_confirm.dart';
import 'package:big_cart/shell/shell_tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

/// The logged-in app: one bottom bar and cart button, with Home, Profile and
/// Favorites switching underneath instead of being pushed as new pages. Like
/// a router outlet: the frame stays, the content changes.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  @override
  void initState() {
    // every login starts on Home, with this account's cart and favorites
    context.read<ShellTabCubit>().show(ShellTabCubit.home);
    context.read<CartCubit>().attemptGetCart();
    context.read<FavoritesCubit>().attemptGetFavorites();
    super.initState();
  }

  void _openCart() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const CartPage()));
  }

  NavigationDestination _destination(IconData icon, String label) =>
      NavigationDestination(
        icon: Icon(icon, size: 30.r, color: AppColors.textSecondary),
        selectedIcon: Icon(icon, size: 30.r, color: AppColors.textPrimary),
        label: label,
      );

  @override
  Widget build(BuildContext context) {
    // Cart and favorite changes are instant; the rare refused one is said
    // here, once, whichever screen it came from
    return MultiBlocListener(
      listeners: [
        BlocListener<CartCubit, CartState>(
          listenWhen: (before, now) =>
              now.error != null && now.error != before.error,
          listener: (context, state) => showCartError(context, state.error),
        ),
        BlocListener<FavoritesCubit, FavoritesState>(
          listenWhen: (before, now) =>
              now.error != null && now.error != before.error,
          listener: (context, state) => showCartError(context, state.error),
        ),
      ],
      child: BlocBuilder<ShellTabCubit, int>(
        builder: (context, tab) => PopScope(
          // back from Profile or Favorites goes to Home first, then leaves
          canPop: tab == ShellTabCubit.home,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) {
              context.read<ShellTabCubit>().show(ShellTabCubit.home);
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.backgroundPrimary,
            // all three stay alive, so switching back keeps scroll and data
            body: IndexedStack(
              index: tab,
              children: const [
                HomePage(),
                ProfilePage(),
                CartPage.favorites(),
              ],
            ),
            floatingActionButton: Container(
              width: 85.w,
              height: 85.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryDark,
                border: Border.all(width: 10.w, color: Colors.white),
              ),
              child: IconButton(
                onPressed: _openCart,
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: NavigationBar(
              selectedIndex: tab,
              onDestinationSelected: (index) {
                // the last slot is the cart button's space, not a tab
                if (index <= ShellTabCubit.favorites) {
                  context.read<ShellTabCubit>().show(index);
                }
              },
              height: 50.h,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              backgroundColor: Colors.white,
              indicatorColor: Colors.transparent,
              destinations: [
                _destination(Icons.home_outlined, 'Home'),
                _destination(Icons.person_outline, 'Profile'),
                _destination(Icons.favorite_outline, 'Favorites'),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
