import 'package:big_cart/core/colors.dart';
import 'package:big_cart/features/account/presentation/pages/profile_page.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:big_cart/features/buy/presentation/pages/cart_page.dart';
import 'package:big_cart/features/buy/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

/// Which tab the shell shows. Pages opened on top of it (the cart's
/// "Start shopping") set it to switch tabs before popping back.
final shellTab = ValueNotifier<int>(0);

/// The logged-in app: one bottom bar and cart button, with Home, Profile and
/// Favorites switching underneath instead of being pushed as new pages. Like
/// a router outlet: the frame stays, the content changes.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const _favoritesTab = 2;

  @override
  void initState() {
    // every login starts on Home
    shellTab.value = 0;
    super.initState();
  }

  Future<void> _openCart() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const CartPage()));
    // the cart and favorites share CartCubit, so favorites reloads its own
    // list once the cart closes over it
    if (mounted && shellTab.value == _favoritesTab) {
      context.read<CartCubit>().attemptGetCartItems(isFavorites: true);
    }
  }

  NavigationDestination _destination(IconData icon, String label) =>
      NavigationDestination(
        icon: Icon(icon, size: 30.r, color: AppColors.textSecondary),
        selectedIcon: Icon(icon, size: 30.r, color: AppColors.textPrimary),
        label: label,
      );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: shellTab,
      builder: (context, tab, _) => PopScope(
        // back from Profile or Favorites goes to Home first, then leaves
        canPop: tab == 0,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) shellTab.value = 0;
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundPrimary,
          body: IndexedStack(
            index: tab,
            children: [
              // Home and Profile stay alive, so switching back keeps their
              // scroll and data; Favorites is rebuilt, so it's always fresh
              const HomePage(),
              const ProfilePage(),
              tab == _favoritesTab
                  ? const CartPage.favorites()
                  : const SizedBox.shrink(),
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
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tab,
            onDestinationSelected: (index) {
              // the last slot is the cart button's space, not a tab
              if (index <= _favoritesTab) shellTab.value = index;
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
    );
  }
}
