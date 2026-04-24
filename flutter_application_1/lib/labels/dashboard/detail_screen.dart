import 'package:flutter/material.dart';
import 'package:flutter_application_1/RestraurantCard widget/constants/color.dart';

Map<String, String>? _detailImageHeaders(String url) {
  final uri = Uri.tryParse(url);
  final host = uri?.host.toLowerCase() ?? '';

  if (host.contains('pngtree.com')) {
    return const {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36',
      'Referer': 'https://pngtree.com/',
    };
  }

  if (host.contains('vecteezy.com')) {
    return const {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36',
      'Referer': 'https://www.vecteezy.com/',
    };
  }

  if (host.contains('dreamstime.com')) {
    return const {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36',
      'Referer': 'https://www.dreamstime.com/',
    };
  }

  return null;
}

String? _detailFallbackImageUrl(String url) {
  if (url ==
      'https://png.pngtree.com/png-vector/20231121/ourmid/pngtree-dragon-rolls-a-ceramic-plate-png-image_10679575.png') {
    return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQKzdmFUAHqL_xJERUDyv-Q6MYpZgPoHAOdw&s';
  }

  return null;
}

class DetailScreen extends StatelessWidget {
  final String title;
  const DetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final details = _restaurantDetails[title] ?? _defaultRestaurantDetails;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: kPink,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: kPink),
                  Image.network(
                    details.heroImageUrl,
                    headers: _detailImageHeaders(details.heroImageUrl),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      final fallbackUrl =
                          _detailFallbackImageUrl(details.heroImageUrl);
                      if (fallbackUrl != null) {
                        return Image.network(
                          fallbackUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: kPink,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.image_outlined,
                                color: Colors.white54,
                                size: 84,
                              ),
                            );
                          },
                        );
                      }

                      return Container(
                        color: kPink,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.image_outlined,
                          color: Colors.white54,
                          size: 84,
                        ),
                      );
                    },
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.18),
                          Colors.black.withValues(alpha: 0.35),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: kPinkLight,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    details.rating,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children: [
                            _InfoChip(
                              icon: Icons.access_time,
                              label: details.deliveryTime,
                            ),
                            _InfoChip(
                              icon: Icons.delivery_dining,
                              label: details.deliveryLabel,
                            ),
                            _InfoChip(
                              icon: Icons.discount_outlined,
                              label: details.offerLabel,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),
                        const Text(
                          'Popular Items',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: details.menuItems.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, indent: 16, endIndent: 16),
                    itemBuilder: (_, i) => _MenuItemTile(
                      item: details.menuItems[i],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: kPink,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'View Menu',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey, size: 14),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}

class _MenuItemTile extends StatelessWidget {
  final _MenuItemData item;
  const _MenuItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(
              item.imageUrl,
              headers: _detailImageHeaders(item.imageUrl),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                final fallbackUrl = _detailFallbackImageUrl(item.imageUrl);
                if (fallbackUrl != null) {
                  return Image.network(
                    fallbackUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image_outlined,
                        color: Colors.brown,
                        size: 34,
                      );
                    },
                  );
                }

                return const Icon(
                  Icons.image_outlined,
                  color: Colors.brown,
                  size: 34,
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.description,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 5),
                Text(
                  item.price,
                  style: const TextStyle(
                    color: kPink,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: kPink,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}

class _RestaurantDetails {
  final String heroImageUrl;
  final String rating;
  final String deliveryTime;
  final String deliveryLabel;
  final String offerLabel;
  final List<_MenuItemData> menuItems;

  const _RestaurantDetails({
    required this.heroImageUrl,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryLabel,
    required this.offerLabel,
    required this.menuItems,
  });
}

class _MenuItemData {
  final String name;
  final String description;
  final String price;
  final String imageUrl;

  const _MenuItemData({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

const _defaultRestaurantDetails = _RestaurantDetails(
  heroImageUrl:
      'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=1200&q=80',
  rating: '4.8',
  deliveryTime: '20-35 min',
  deliveryLabel: 'Free delivery',
  offerLabel: '20% off',
  menuItems: [
    _MenuItemData(
      name: 'Chef Special',
      description: 'Handpicked special prepared fresh today',
      price: '\$12.99',
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=400&q=80',
    ),
  ],
);

const Map<String, _RestaurantDetails> _restaurantDetails = {
  'Burger King': _RestaurantDetails(
    heroImageUrl:
        'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=1200&q=80',
    rating: '4.8',
    deliveryTime: '20-35 min',
    deliveryLabel: 'Free delivery',
    offerLabel: '20% off',
    menuItems: [
      _MenuItemData(
        name: 'Signature Burger',
        description: 'Beef patty, cheese, special sauce',
        price: '\$7.99',
        imageUrl:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Crispy Chicken',
        description: 'Fried chicken, coleslaw, pickles',
        price: '\$6.50',
        imageUrl:
            'https://images.unsplash.com/photo-1562967916-eb82221dfb92?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Veggie Wrap',
        description: 'Fresh vegetables, hummus, tortilla',
        price: '\$5.99',
        imageUrl:
            'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Loaded Fries',
        description: 'Cheese sauce, bacon, jalapenos',
        price: '\$4.50',
        imageUrl:
            'https://images.unsplash.com/photo-1576107232684-1279f390859f?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Panda Special',
        description: 'Chef\'s exclusive creation today',
        price: '\$12.99',
        imageUrl:
            'https://static.vecteezy.com/system/resources/previews/027/145/412/non_2x/delicious-jalapeno-burger-isolated-on-transparent-background-png.png',
      ),
    ],
  ),
  'Pizza Hut': _RestaurantDetails(
    heroImageUrl:
        'https://thumbs.dreamstime.com/b/pizza-truffle-truffles-ruccola-cheese-white-table-cloth-97193596.jpg',
    rating: '4.7',
    deliveryTime: '20-35 min',
    deliveryLabel: 'Free delivery',
    offerLabel: '15% off',
    menuItems: [
      _MenuItemData(
        name: 'Truffle Pizza',
        description: 'Truffle cream, mozzarella, fresh arugula',
        price: '\$15.00',
        imageUrl:
            'https://thumbs.dreamstime.com/b/pizza-truffle-truffles-ruccola-cheese-white-table-cloth-97193596.jpg',
      ),
      _MenuItemData(
        name: 'Cheese Slice',
        description: 'Melting mozzarella with a golden crust',
        price: '\$4.99',
        imageUrl:
            'https://png.pngtree.com/png-vector/20250426/ourmid/pngtree-3d-melting-cheese-pizza-slice-on-png-image_16116836.png',
      ),
      _MenuItemData(
        name: 'Dragon Roll Combo',
        description: 'Featured sushi combo in the menu',
        price: '\$12.50',
        imageUrl:
            'https://png.pngtree.com/png-vector/20231121/ourmid/pngtree-dragon-rolls-a-ceramic-plate-png-image_10679575.png',
      ),
      _MenuItemData(
        name: 'Korean BBQ Pizza',
        description: 'Savory Korean BBQ topping with rich sauce',
        price: '\$11.99',
        imageUrl:
            'https://static.vecteezy.com/system/resources/thumbnails/036/409/436/small/ai-generated-savoring-korean-bbq-png.png',
      ),
    ],
  ),
  'KFC Cambodia': _RestaurantDetails(
    heroImageUrl:
        'https://images.unsplash.com/photo-1513639776629-7b61b0ac49cb?auto=format&fit=crop&w=1200&q=80',
    rating: '4.6',
    deliveryTime: '10-20 min',
    deliveryLabel: 'Free delivery',
    offerLabel: '20% off',
    menuItems: [
      _MenuItemData(
        name: 'Original Chicken',
        description: 'Classic crispy chicken pieces',
        price: '\$7.50',
        imageUrl:
            'https://images.unsplash.com/photo-1562967916-eb82221dfb92?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Chicken Burger',
        description: 'Tender chicken fillet with soft bun',
        price: '\$6.20',
        imageUrl:
            'https://images.unsplash.com/photo-1606755962773-d324e0a13086?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Popcorn Chicken',
        description: 'Crunchy bite-sized chicken pieces',
        price: '\$4.80',
        imageUrl:
            'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Family Fries',
        description: 'Seasoned fries for sharing',
        price: '\$3.50',
        imageUrl:
            'https://images.unsplash.com/photo-1576107232684-1279f390859f?auto=format&fit=crop&w=400&q=80',
      ),
    ],
  ),
  'Spicy Panda Burger': _RestaurantDetails(
    heroImageUrl:
        'https://static.vecteezy.com/system/resources/previews/027/145/412/non_2x/delicious-jalapeno-burger-isolated-on-transparent-background-png.png',
    rating: '4.8',
    deliveryTime: '15-25 min',
    deliveryLabel: 'Hot deal',
    offerLabel: 'Exclusive',
    menuItems: [
      _MenuItemData(
        name: 'Spicy Panda Burger',
        description: 'Jalapeno burger with bold house sauce',
        price: '\$8.99',
        imageUrl:
            'https://static.vecteezy.com/system/resources/previews/027/145/412/non_2x/delicious-jalapeno-burger-isolated-on-transparent-background-png.png',
      ),
    ],
  ),
  'Dragon Roll Set': _RestaurantDetails(
    heroImageUrl:
        'https://png.pngtree.com/png-vector/20231121/ourmid/pngtree-dragon-rolls-a-ceramic-plate-png-image_10679575.png',
    rating: '4.9',
    deliveryTime: '20-30 min',
    deliveryLabel: 'Free delivery',
    offerLabel: 'Exclusive',
    menuItems: [
      _MenuItemData(
        name: 'Dragon Roll Set',
        description: 'Dragon rolls served on a ceramic plate',
        price: '\$12.50',
        imageUrl:
            'https://png.pngtree.com/png-vector/20231121/ourmid/pngtree-dragon-rolls-a-ceramic-plate-png-image_10679575.png',
      ),
    ],
  ),
  'Truffle Pizza': _RestaurantDetails(
    heroImageUrl:
        'https://thumbs.dreamstime.com/b/pizza-truffle-truffles-ruccola-cheese-white-table-cloth-97193596.jpg',
    rating: '4.7',
    deliveryTime: '20-35 min',
    deliveryLabel: 'Free delivery',
    offerLabel: 'Exclusive',
    menuItems: [
      _MenuItemData(
        name: 'Truffle Pizza',
        description: 'Truffle pizza with cheese and fresh arugula',
        price: '\$15.00',
        imageUrl:
            'https://thumbs.dreamstime.com/b/pizza-truffle-truffles-ruccola-cheese-white-table-cloth-97193596.jpg',
      ),
    ],
  ),
  'Korean BBQ Bowl': _RestaurantDetails(
    heroImageUrl:
        'https://static.vecteezy.com/system/resources/thumbnails/036/409/436/small/ai-generated-savoring-korean-bbq-png.png',
    rating: '4.6',
    deliveryTime: '20-30 min',
    deliveryLabel: 'Free delivery',
    offerLabel: 'Exclusive',
    menuItems: [
      _MenuItemData(
        name: 'Korean BBQ Bowl',
        description: 'Rice bowl with Korean BBQ and vegetables',
        price: '\$10.99',
        imageUrl:
            'https://static.vecteezy.com/system/resources/thumbnails/036/409/436/small/ai-generated-savoring-korean-bbq-png.png',
      ),
    ],
  ),
};
