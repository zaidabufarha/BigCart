import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/favorites_cubit.dart';
import 'package:big_cart/features/buy/presentation/pages/product_page.dart';
import 'package:big_cart/features/buy/presentation/widgets/remove_confirm.dart';
import 'package:big_cart/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

// The heart and the cart control both read app-wide cubits, so every card,
// the product page and the Favorites tab always agree.
class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard(this.product, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductCardState();
  }
}

class _ProductCardState extends State<ProductCard> {
  void setQuantity(int next) =>
      context.read<CartCubit>().attemptSetQuantity(widget.product, next);

  // the last one asks first, like the web client
  Future<void> confirmRemove() async {
    if (await confirmRemoveFromCart(context, widget.product.name)) {
      setQuantity(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.select<FavoritesCubit, bool>(
      (favorites) => favorites.isFavorite(widget.product),
    );
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => ProductPage(widget.product)),
          ),
        );
      },
      child: SizedBox(
        height: 300.h,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.textSecondary.withAlpha(20)),
            color: AppColors.backgroundPrimary,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () => context
                      .read<FavoritesCubit>()
                      .attemptToggleFavorite(widget.product),
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  margin: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.product.color,
                  ),
                  child: Center(
                    child: AppImage(
                      widget.product.imagePath,
                      width: 100.w,
                      height: 100.h,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 120.h,
                child: SizedBox(
                  height: 200.h,
                  child: Column(
                    children: [
                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: Fonts.paragraphRegular(size: 13).copyWith(
                          color: AppColors.primaryDark,
                        ),
                      ),
                      Text(
                        widget.product.name,
                        style: Fonts.titleBold(size: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.product.amount,
                        style: Fonts.paragraphRegular(size: 12),
                      ),
                      Divider(
                        thickness: 1.h,
                      ),
                      // "Add to cart" until it's in the cart, then − qty +
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, cart) {
                          final quantity =
                              cart.items[widget.product.id]?.quantity ?? 0;
                          return quantity == 0
                              ? _addButton()
                              : _stepper(quantity);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              (widget.product.isNew)
                  ? Positioned(
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        color: Color(0xFFFDEFD5),
                        child: Text(
                          'NEW',
                          style: Fonts.label().copyWith(
                            color: Color(0xFFE8AD41),
                          ),
                        ),
                      ),
                    )
                  : (widget.product.discount != 0)
                  ? Positioned(
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        color: Color(0xFFFEE4E4),
                        child: Text(
                          '-${widget.product.discount}%',
                          style: Fonts.label().copyWith(
                            color: Color(0xFFF56262),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addButton() => TextButton(
    onPressed: () => setQuantity(1),
    child: Row(
      spacing: 15.w,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.shopping_bag_outlined,
          color: AppColors.primaryDark,
        ),
        Text(
          'Add to cart',
          style: Fonts.paragraphRegular(size: 14),
        ),
      ],
    ),
  );

  Widget _stepper(int quantity) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(
        // at one, minus means remove: red, and it asks first
        onPressed: quantity == 1
            ? confirmRemove
            : () => setQuantity(quantity - 1),
        icon: Icon(
          Icons.remove,
          color: quantity == 1 ? Colors.red : AppColors.primaryDark,
        ),
      ),
      Text(
        '$quantity',
        style: Fonts.titleBold(size: 16),
      ),
      IconButton(
        onPressed: () => setQuantity(quantity + 1),
        icon: Icon(Icons.add, color: AppColors.primaryDark),
      ),
    ],
  );
}
