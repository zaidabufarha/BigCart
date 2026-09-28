class SplashData {
  const SplashData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
  final String title;
  final String subtitle;
  final String imagePath;
}

const List<SplashData> splashDataList = [
  SplashData(
    title: 'Welcome to',
    subtitle: 'Fresh groceries from local farms, delivered to your door.',
    imagePath: 'assets/green_bag.jpg',
  ),
  SplashData(
    title: 'Buy Quality Dairy Products',
    subtitle: 'Milk, cheese and eggs, kept cold from the farm to your fridge.',
    imagePath: 'assets/eggs.jpg',
  ),
  SplashData(
    title: 'Buy Premium Quality Fruits',
    subtitle: 'Seasonal fruit, picked ripe and packed with care.',
    imagePath: 'assets/lemon_bag.jpg',
  ),
  SplashData(
    title: 'Get Discounts On All Products',
    subtitle: 'New deals every week on the everyday essentials you buy most.',
    imagePath: 'assets/apple.jpg',
  ),
];
