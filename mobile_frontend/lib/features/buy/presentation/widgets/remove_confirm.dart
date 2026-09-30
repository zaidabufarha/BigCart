import 'package:flutter/material.dart';

/// Asks before the last one of a product leaves the cart (the minus at a
/// quantity of 1), like the web client's RemoveConfirm. True means remove.
Future<bool> confirmRemoveFromCart(BuildContext context, String name) async {
  final remove = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Remove from cart?'),
      content: Text('$name will be taken out of your cart.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Keep'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Remove', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
  return remove == true;
}

/// A cart change the server refused; the cart has already been put back.
void showCartError(BuildContext context, String? message) {
  if (message == null || !context.mounted) return;
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: Colors.red),
  );
}
