import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/favorites_cubit.dart';
import 'package:big_cart/features/buy/presentation/pages/shipping_page.dart';
import 'package:big_cart/features/buy/presentation/widgets/cart_card.dart';
import 'package:big_cart/shell/shell_tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

/// The cart, or with [favorites] the Favorites tab. Both just draw an
/// app-wide cubit (CartCubit, FavoritesCubit), whose changes are instant;
/// a refused one is said by the shell.
class CartPage extends StatefulWidget {
  final bool favorites;
  const CartPage({super.key}) : favorites = false;
  const CartPage.favorites({super.key}) : favorites = true;

  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // opening the cart refreshes it; favorites stay loaded by the shell
    if (!widget.favorites) context.read<CartCubit>().attemptGetCart();
    super.initState();
  }

  void onClick([List<CartItem>? items]) {
    if (items != null && items.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ShippingPage(items)),
      );
    } else {
      // "Start shopping": back to the shell, on the Home tab
      context.read<ShellTabCubit>().show(ShellTabCubit.home);
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  double sumOfPrices(List<CartItem> items) {
    double sum = 0;
    for (CartItem item in items) {
      sum +=
          item.product.price *
          item.quantity *
          (100 - item.product.discount) /
          100;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        // no back arrow as the shell's Favorites tab; pushed, it has one
        automaticallyImplyLeading: false,
        leading: Navigator.of(context).canPop()
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_outlined),
              )
            : null,
        centerTitle: true,
        title: Text(
          (widget.favorites) ? 'Favorites' : 'Shopping Cart',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: widget.favorites ? _favoritesBody() : _cartBody(),
    );
  }

  Widget _cartBody() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cart) => cart.loaded
          ? _content(cart.items.values.toList())
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _favoritesBody() {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, favorites) => favorites.loaded
          ? _content([
              for (final product in favorites.products.values)
                CartItem(product, 1),
            ])
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _content(List<CartItem> products) {
    if (products.isEmpty) return _empty();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: SingleChildScrollView(
              child: Column(
                spacing: 10.h,
                children: [
                  for (CartItem item in products)
                    (widget.favorites)
                        ? CartCard.favorite(item)
                        : CartCard(item),
                ],
              ),
            ),
          ),
        ),
        if (!widget.favorites)
          Container(
            padding: const EdgeInsets.all(20),
            color: AppColors.backgroundPrimary,
            child: Column(
              spacing: 10.h,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: Fonts.paragraphMedium(),
                    ),
                    Text(
                      '\$${sumOfPrices(products).toStringAsFixed(2)}',
                      style: Fonts.paragraphMedium(),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping charges',
                      style: Fonts.paragraphMedium(),
                    ),
                    // the price depends on the method picked at checkout
                    Text(
                      'At checkout',
                      style: Fonts.paragraphMedium(),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Fonts.titleBold(size: 18),
                    ),
                    Text(
                      '\$${sumOfPrices(products).toStringAsFixed(2)}',
                      style: Fonts.titleBold(size: 18),
                    ),
                  ],
                ),
                SizedBox(),
                GreenGradientButton(
                  () => onClick(products),
                  'Checkout',
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _empty() {
    return Column(
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
                    (widget.favorites)
                        ? Icons.favorite_outline
                        : Icons.shopping_bag_outlined,
                    color: (widget.favorites)
                        ? Colors.red
                        : AppColors.primaryDark,
                    size: 200.r,
                  ),
                  Text(
                    (widget.favorites)
                        ? 'No favorites added'
                        : 'Your cart is empty!',
                    textAlign: TextAlign.center,
                    style: Fonts.titleBold(size: 30),
                  ),
                  Text(
                    (widget.favorites)
                        ? 'Add items to your favorites by pressing the heart icon.'
                        : 'Add items to your cart to see them here.',
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
          child: GreenGradientButton(
            onClick,
            'Start shopping',
          ),
        ),
      ],
    );
  }
}
