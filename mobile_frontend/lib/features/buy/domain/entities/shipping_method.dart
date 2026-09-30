/// A delivery option at checkout. [title] is also what's sent to the backend
/// as the order's shipping method, and the backend charges [price]
/// (backend/src/graphql/shipping.ts), so both must match it there.
class ShippingMethod {
  final String title;
  final double price;
  final String description;

  const ShippingMethod({
    required this.title,
    required this.price,
    required this.description,
  });
}

const shippingMethods = [
  ShippingMethod(
    title: 'Standard Delivery',
    price: 3,
    description: 'Delivered within 4 days.',
  ),
  ShippingMethod(
    title: 'Next Day Delivery',
    price: 5,
    description: 'Delivered within 24 hours.',
  ),
  ShippingMethod(
    title: '1-Hour Delivery',
    price: 10,
    description: 'Delivered within an hour.',
  ),
];
