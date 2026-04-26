import 'package:flutter/material.dart';
import 'package:flutter_application_1/RestraurantCard widget/constants/color.dart';
import 'package:flutter_application_1/labels/dashboard/cart_screen.dart';
import 'package:flutter_application_1/services/order_store.dart';

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
                      final fallbackUrl = _detailFallbackImageUrl(
                        details.heroImageUrl,
                      );
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
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 14,
                                  ),
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
                        if (details.subtitle.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            details.subtitle,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ],
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
                        const SizedBox(height: 18),
                        _DetailSection(
                          title: 'About',
                          child: Text(
                            details.about,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _DetailSection(
                          title: 'Store Information',
                          child: Column(
                            children: [
                              _StoreFactRow(
                                icon: Icons.location_on_outlined,
                                label: 'Address',
                                value: details.address,
                              ),
                              _StoreFactRow(
                                icon: Icons.schedule,
                                label: 'Opening hours',
                                value: details.openingHours,
                              ),
                              _StoreFactRow(
                                icon: Icons.payments_outlined,
                                label: 'Payment',
                                value: details.paymentMethods,
                              ),
                              _StoreFactRow(
                                icon: Icons.shopping_basket_outlined,
                                label: 'Minimum order',
                                value: details.minOrder,
                              ),
                            ],
                          ),
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
                      restaurant: title,
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
        child: AnimatedBuilder(
          animation: OrderStore.instance,
          builder: (context, _) {
            final count = OrderStore.instance.itemCount;
            return ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPink,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                count == 0 ? 'View Cart' : 'View Cart ($count)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void _showAddedMessage(BuildContext context, String name) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('$name added to cart'),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: 'Cart',
        textColor: Colors.white,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CartScreen()),
        ),
      ),
      backgroundColor: kPink,
    ),
  );
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
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _DetailSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _StoreFactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StoreFactRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: kPink, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItemTile extends StatelessWidget {
  final String restaurant;
  final _MenuItemData item;
  const _MenuItemTile({required this.restaurant, required this.item});

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
          InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              OrderStore.instance.addItem(
                restaurant: restaurant,
                name: item.name,
                description: item.description,
                priceLabel: item.price,
                imageUrl: item.imageUrl,
              );
              _showAddedMessage(context, item.name);
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: kPink,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}

class _RestaurantDetails {
  final String heroImageUrl;
  final String subtitle;
  final String rating;
  final String deliveryTime;
  final String deliveryLabel;
  final String offerLabel;
  final String about;
  final String address;
  final String openingHours;
  final String paymentMethods;
  final String minOrder;
  final List<_MenuItemData> menuItems;

  const _RestaurantDetails({
    required this.heroImageUrl,
    this.subtitle = '',
    required this.rating,
    required this.deliveryTime,
    required this.deliveryLabel,
    required this.offerLabel,
    this.about =
        'Fresh meals and daily favorites prepared for quick delivery around Phnom Penh.',
    this.address = 'Phnom Penh, Cambodia',
    this.openingHours = 'Open daily, 8:00 AM - 10:00 PM',
    this.paymentMethods = 'Cash, card, and ABA PAY',
    this.minOrder = '\$5.00',
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
  'Lucky Supermarket Sen Sok': _RestaurantDetails(
    heroImageUrl: 'https://www.dfilucky.com/logo.png',
    subtitle: 'Supermarket',
    rating: '4.5',
    deliveryTime: '15-40 min',
    deliveryLabel: 'Free for first order',
    offerLabel: '\$3 off \$17',
    about:
        'A grocery shop for fresh produce, snacks, drinks, pantry products, cleaning supplies, and everyday household needs.',
    address: 'Sen Sok, Phnom Penh',
    openingHours: 'Open daily, 7:00 AM - 10:00 PM',
    paymentMethods: 'Cash, card, and ABA PAY',
    minOrder: '\$5.00',
    menuItems: [
      _MenuItemData(
        name: 'Fresh Vegetable Box',
        description: 'Mixed greens, carrots, cucumber, and herbs',
        price: '\$6.50',
        imageUrl:
            'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Fruit Basket',
        description: 'Seasonal fruit for home or office',
        price: '\$8.90',
        imageUrl:
            'https://images.unsplash.com/photo-1610832958506-aa56368176cf?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Milk and Cereal Set',
        description: 'Breakfast essentials bundle',
        price: '\$5.75',
        imageUrl:
            'https://images.unsplash.com/photo-1517093157656-b9eccef91cb1?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Household Cleaning Pack',
        description: 'Detergent, dish soap, and surface cleaner',
        price: '\$9.20',
        imageUrl:
            'https://images.unsplash.com/photo-1583947215259-38e31be8751f?auto=format&fit=crop&w=400&q=80',
      ),
    ],
  ),
  'Lucky Supermarket': _RestaurantDetails(
    heroImageUrl: 'https://www.dfilucky.com/logo.png',
    subtitle: 'Supermarket',
    rating: '4.5',
    deliveryTime: '25-50 min',
    deliveryLabel: 'Free for first order',
    offerLabel: '\$3 off \$17',
    about:
        'Popular supermarket selection with groceries, drinks, snacks, frozen items, and home essentials.',
    address: 'Phnom Penh, Cambodia',
    openingHours: 'Open daily, 7:00 AM - 10:00 PM',
    paymentMethods: 'Cash, card, and ABA PAY',
    minOrder: '\$5.00',
    menuItems: [
      _MenuItemData(
        name: 'Grocery Starter Basket',
        description: 'Rice, eggs, milk, vegetables, and snacks',
        price: '\$18.00',
        imageUrl:
            'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Drinks Bundle',
        description: 'Water, juice, soda, and tea',
        price: '\$7.50',
        imageUrl:
            'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?auto=format&fit=crop&w=400&q=80',
      ),
    ],
  ),
  'AEON': _RestaurantDetails(
    heroImageUrl:
        'https://yt3.googleusercontent.com/-GOuQcQWIOzYibpMEO9kYZzKhqergcwHThY4-oQvG4MK27HWHuMpBtFkRt7rluGiFsvuJAeKvA=s900-c-k-c0x00ffffff-no-rj',
    subtitle: 'Convenience and groceries',
    rating: '4.1',
    deliveryTime: '5-30 min',
    deliveryLabel: 'Fast delivery',
    offerLabel: '\$2 off \$12',
    about:
        'Convenience store essentials including ready-to-eat food, beverages, snacks, personal care, and household basics.',
    address: 'AEON area, Phnom Penh',
    openingHours: 'Open daily, 8:00 AM - 11:00 PM',
    paymentMethods: 'Cash, card, and ABA PAY',
    minOrder: '\$4.00',
    menuItems: [
      _MenuItemData(
        name: 'Ready Meal Set',
        description: 'Quick lunch or dinner option',
        price: '\$4.25',
        imageUrl:
            'https://images.unsplash.com/photo-1543352634-a1c51d9f1fa7?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Snack and Drink Combo',
        description: 'Chips, chocolate, and bottled drink',
        price: '\$3.75',
        imageUrl:
            'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?auto=format&fit=crop&w=400&q=80',
      ),
    ],
  ),
  'Aeon MaxValu Supermarket (Toul...)': _RestaurantDetails(
    heroImageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpy52L4vPX3zzsTDFoP6foIcQNeYAIhDaiVQ&s',
    subtitle: 'Supermarket',
    rating: '4.3',
    deliveryTime: '10-35 min',
    deliveryLabel: 'Scheduled delivery',
    offerLabel: 'Daily essentials',
    about:
        'Neighborhood supermarket for fresh food, imported grocery items, chilled products, and household supplies.',
    address: 'Toul Kork, Phnom Penh',
    openingHours: 'Open daily, 8:00 AM - 10:00 PM',
    paymentMethods: 'Cash, card, and ABA PAY',
    minOrder: '\$5.00',
    menuItems: [
      _MenuItemData(
        name: 'Fresh Food Set',
        description: 'Vegetables, protein, and cooking basics',
        price: '\$12.50',
        imageUrl:
            'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Imported Snacks',
        description: 'Sweet and salty snack selection',
        price: '\$6.40',
        imageUrl:
            'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?auto=format&fit=crop&w=400&q=80',
      ),
    ],
  ),
  'Aeon MaxValu Supermarl...': _RestaurantDetails(
    heroImageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpy52L4vPX3zzsTDFoP6foIcQNeYAIhDaiVQ&s',
    subtitle: 'Supermarket',
    rating: '4.3',
    deliveryTime: '10-35 min',
    deliveryLabel: 'Scheduled delivery',
    offerLabel: 'Daily essentials',
    about:
        'Neighborhood supermarket for fresh food, imported grocery items, chilled products, and household supplies.',
    address: 'Phnom Penh, Cambodia',
    openingHours: 'Open daily, 8:00 AM - 10:00 PM',
    paymentMethods: 'Cash, card, and ABA PAY',
    minOrder: '\$5.00',
    menuItems: [
      _MenuItemData(
        name: 'Daily Essentials Basket',
        description: 'Core grocery products for the week',
        price: '\$15.00',
        imageUrl:
            'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=400&q=80',
      ),
    ],
  ),
  'Chip Mong Supermarket...': _RestaurantDetails(
    heroImageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqWb3y6VEA-huZg6U1MWrGJElHtyM4UsEoPA&s',
    subtitle: 'Supermarket',
    rating: '4.4',
    deliveryTime: '15-45 min',
    deliveryLabel: 'Grocery delivery',
    offerLabel: 'Popular shop',
    about:
        'Supermarket selection with fresh ingredients, snacks, beverages, frozen goods, and home products.',
    address: 'Phnom Penh, Cambodia',
    openingHours: 'Open daily, 8:00 AM - 10:00 PM',
    paymentMethods: 'Cash, card, and ABA PAY',
    minOrder: '\$5.00',
    menuItems: [
      _MenuItemData(
        name: 'Family Grocery Pack',
        description: 'Rice, vegetables, fruit, drinks, and snacks',
        price: '\$22.00',
        imageUrl:
            'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=400&q=80',
      ),
    ],
  ),
  'Khmer New Year': _RestaurantDetails(
    heroImageUrl:
        'https://static.vecteezy.com/system/resources/thumbnails/043/030/930/small/happy-khmer-new-year-vector.jpg',
    subtitle: 'Seasonal celebration',
    rating: '4.6',
    deliveryTime: '20-45 min',
    deliveryLabel: 'Seasonal items',
    offerLabel: 'Holiday deals',
    about:
        'Festival picks for Khmer New Year, including snacks, drinks, gifts, decorations, and family sharing items.',
    address: 'Available in Phnom Penh',
    openingHours: 'Seasonal collection',
    paymentMethods: 'Cash, card, and ABA PAY',
    minOrder: '\$3.00',
    menuItems: [
      _MenuItemData(
        name: 'New Year Snack Box',
        description: 'Sweet and salty snacks for sharing',
        price: '\$9.90',
        imageUrl:
            'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Family Drinks Pack',
        description: 'Assorted soft drinks and bottled water',
        price: '\$7.25',
        imageUrl:
            'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?auto=format&fit=crop&w=400&q=80',
      ),
    ],
  ),
  'Groceries': _RestaurantDetails(
    heroImageUrl:
        'https://i.pinimg.com/1200x/60/c7/b3/60c7b3e11b79c1529b8741048f526b9d.jpg',
    subtitle: 'Daily essentials category',
    rating: '4.5',
    deliveryTime: '15-45 min',
    deliveryLabel: 'Many shops available',
    offerLabel: 'Fresh picks',
    about:
        'Browse grocery staples, fresh produce, dairy, pantry items, snacks, drinks, and household supplies.',
    address: 'Multiple stores near your selected location',
    openingHours: 'Hours vary by store',
    paymentMethods: 'Cash, card, and ABA PAY',
    minOrder: 'Varies by store',
    menuItems: [
      _MenuItemData(
        name: 'Vegetables',
        description: 'Fresh greens and cooking ingredients',
        price: 'From \$1.00',
        imageUrl:
            'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Fruit',
        description: 'Seasonal fruit selections',
        price: 'From \$2.00',
        imageUrl:
            'https://images.unsplash.com/photo-1610832958506-aa56368176cf?auto=format&fit=crop&w=400&q=80',
      ),
    ],
  ),
  'Convenience': _RestaurantDetails(
    heroImageUrl:
        'https://i.pinimg.com/1200x/37/58/fd/3758fd8c93654ec516d0635134a076d2.jpg',
    subtitle: 'Quick essentials category',
    rating: '4.4',
    deliveryTime: '5-30 min',
    deliveryLabel: 'Fast delivery',
    offerLabel: 'Quick buys',
    about:
        'Fast access to drinks, snacks, ready meals, personal care items, and last-minute household needs.',
    address: 'Multiple stores near your selected location',
    openingHours: 'Hours vary by store',
    paymentMethods: 'Cash, card, and ABA PAY',
    minOrder: 'Varies by store',
    menuItems: [
      _MenuItemData(
        name: 'Ready Meals',
        description: 'Quick food for lunch, dinner, or late night',
        price: 'From \$2.50',
        imageUrl:
            'https://images.unsplash.com/photo-1543352634-a1c51d9f1fa7?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Snacks',
        description: 'Chips, chocolate, and biscuits',
        price: 'From \$1.00',
        imageUrl:
            'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?auto=format&fit=crop&w=400&q=80',
      ),
    ],
  ),
  'Beverages & Alcohol': _RestaurantDetails(
    heroImageUrl:
        'https://i.pinimg.com/736x/86/2d/31/862d311a95bdcd29f191d14fb2cbb780.jpg',
    subtitle: 'Drinks category',
    rating: '4.3',
    deliveryTime: '10-35 min',
    deliveryLabel: 'Age check may apply',
    offerLabel: 'Cold drinks',
    about:
        'Water, juice, coffee, tea, soda, and selected alcoholic beverages from nearby shops.',
    address: 'Multiple stores near your selected location',
    openingHours: 'Hours vary by store',
    paymentMethods: 'Cash, card, and ABA PAY',
    minOrder: 'Varies by store',
    menuItems: [
      _MenuItemData(
        name: 'Soft Drink Pack',
        description: 'Assorted cold drinks',
        price: 'From \$3.00',
        imageUrl:
            'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Coffee and Tea',
        description: 'Canned, bottled, and instant options',
        price: 'From \$1.50',
        imageUrl:
            'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=400&q=80',
      ),
    ],
  ),
  'Bakery': _RestaurantDetails(
    heroImageUrl:
        'https://i.pinimg.com/1200x/3f/29/6f/3f296f9a562dfc4ec090de048f67b59b.jpg',
    subtitle: 'Fresh bakery category',
    rating: '4.5',
    deliveryTime: '15-35 min',
    deliveryLabel: 'Fresh baked',
    offerLabel: 'Bakery picks',
    about:
        'Bread, pastries, cakes, and breakfast bakery items from grocery and bakery partners.',
    address: 'Multiple stores near your selected location',
    openingHours: 'Hours vary by store',
    paymentMethods: 'Cash, card, and ABA PAY',
    minOrder: 'Varies by store',
    menuItems: [
      _MenuItemData(
        name: 'Croissant Box',
        description: 'Buttery croissants for breakfast or tea time',
        price: 'From \$4.00',
        imageUrl:
            'https://images.unsplash.com/photo-1555507036-ab1f4038808a?auto=format&fit=crop&w=400&q=80',
      ),
      _MenuItemData(
        name: 'Fresh Bread',
        description: 'Soft bread and rolls',
        price: 'From \$2.00',
        imageUrl:
            'https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=400&q=80',
      ),
    ],
  ),
};
