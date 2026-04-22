class PandaPickItem {
  final String name;
  final String category;
  final double price;
  final double rating;
  final String deliveryTime;
  final bool isFreeDelivery;
  final String imageUrl;

  const PandaPickItem({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.deliveryTime,
    this.isFreeDelivery = false,
    this.imageUrl = '',
  });
}