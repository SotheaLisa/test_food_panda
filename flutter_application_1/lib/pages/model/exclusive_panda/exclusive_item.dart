class ExclusiveItem {
  final String name;
  final String restaurant;
  final double price;
  final double rating;
  final String imageUrl;
  final bool isExclusive;

  const ExclusiveItem({
    required this.name,
    required this.restaurant,
    required this.price,
    required this.rating,
    this.imageUrl = '',
    this.isExclusive = true,
  });
}