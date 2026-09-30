import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/favorites_cubit.dart';
import 'package:big_cart/features/buy/presentation/widgets/remove_confirm.dart';
import 'package:big_cart/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartCard extends StatefulWidget {
  final CartItem data;
  final bool isFavorite;
  const CartCard(this.data, {super.key}) : isFavorite = false;
  const CartCard.favorite(this.data, {super.key}) : isFavorite = true;

  @override
  State<StatefulWidget> createState() {
    return _CartCardState();
  }
}

class _CartCardState extends State<CartCard> {
  // instant, like the product cards; a refused change is said by the shell
  void setQuantity(int next) =>
      context.read<CartCubit>().attemptSetQuantity(widget.data.product, next);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.data.product.name),
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: ScrollMotion(),
        children: [
          CustomSlidableAction(
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            child: Icon(
              Icons.delete,
              size: 30.r,
            ),
            onPressed: (BuildContext context) {
              if (widget.isFavorite) {
                context.read<FavoritesCubit>().attemptToggleFavorite(
                  widget.data.product,
                );
              } else {
                // swiping is already a deliberate remove, so no dialog
                setQuantity(0);
              }
            },
          ),
        ],
      ),
      child: Container(
        color: AppColors.backgroundPrimary,
        padding: EdgeInsets.all(5),
        child: Row(
          spacing: 10.w,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              margin: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.data.product.color,
              ),
              child: Center(
                child: AppImage(
                  widget.data.product.imagePath,
                  width: 100.w,
                  height: 100.h,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isFavorite
                        ? '\$${widget.data.product.price}'
                        : '\$${widget.data.product.price} x ${widget.data.quantity}',
                    style: Fonts.paragraphMedium().copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Text(
                    widget.data.product.name,
                    style: Fonts.titleBold(),
                  ),
                  Text(
                    widget.data.product.amount,
                    style: Fonts.paragraphMedium(),
                  ),
                ],
              ),
            ),
            if (!widget.isFavorite)
              Column(
                children: [
                  IconButton(
                    onPressed: () => setQuantity(widget.data.quantity + 1),
                    icon: Icon(
                      Icons.add,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Text(
                    widget.data.quantity.toString(),
                    style: Fonts.paragraphRegular(),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (widget.data.quantity > 1) {
                        setQuantity(widget.data.quantity - 1);
                      } else if (await confirmRemoveFromCart(
                        context,
                        widget.data.product.name,
                      )) {
                        setQuantity(0);
                      }
                    },
                    icon: Icon(
                      Icons.remove,
                      color: (widget.data.quantity > 1)
                          ? AppColors.primaryDark
                          : Colors.red,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
