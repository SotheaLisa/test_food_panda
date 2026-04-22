import 'package:flutter/material.dart';
import 'package:flutter_application_1/RestraurantCard widget/constants/color.dart';
import 'package:flutter_application_1/etc/constant.dart';
import 'package:flutter_application_1/components/restaurant.dart';


class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  static const List<Map<String, String>> _categories = [
    {
      'label': 'Khmer New\nYear',
      'image':
          'https://png.pngtree.com/png-vector/20230330/ourmid/pngtree-khmer-illustrator-new-for-year-vector-png-image_6675329.png'
    },
    {
      'label': 'Groceries',
      'image':
          'https://i.pinimg.com/1200x/60/c7/b3/60c7b3e11b79c1529b8741048f526b9d.jpg'
    },
    {
      'label': 'Convenience',
      'image':
          'https://i.pinimg.com/1200x/37/58/fd/3758fd8c93654ec516d0635134a076d2.jpg'
    },
    {
      'label': 'Beverages\n& Alcohol',
      'image':
          'https://i.pinimg.com/736x/86/2d/31/862d311a95bdcd29f191d14fb2cbb780.jpg'
    },
    {
      'label': 'Bakery',
      'image':
          'https://i.pinimg.com/1200x/3f/29/6f/3f296f9a562dfc4ec090de048f67b59b.jpg'
    },
  ];

  static const List<Map<String, String>> _shops = [
    {
      'name': 'Chip Mong\nSupermarket...',
      'time': '15-45 min',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqWb3y6VEA-huZg6U1MWrGJElHtyM4UsEoPA&s'
    },
    {
      'name': 'Lucky\nSupermarket',
      'time': '25-50 min',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAtV7wUW0l62mmbcHx49fB8WTsvrKKP65aQA&s'
    },
    {
      'name': 'AEON',
      'time': '5-30 min',
      'image':
          'https://companieslogo.com/img/orig/8267.T-a5b1f27a.png?t=1720244490'
    },
    {
      'name': 'Aeon MaxValu\nSupermarl...',
      'time': '10-35 min',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpy52L4vPX3zzsTDFoP6foIcQNeYAIhDaiVQ&s'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _GroceryHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // ── Category horizontal scroll ──────────────────────────
                  // FIX: increased height from 110 → 125 to fit icon + 2-line label
                  SizedBox(
                    height: 125,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 12),
                      itemCount: _categories.length,
                      itemBuilder: (_, i) {
                        final c = _categories[i];
                        return SizedBox(
                          width: 80,
                          // FIX: Column inside SizedBox with fixed width —
                          // no more bottom overflow because height is set on parent
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade50,
                                  borderRadius:
                                      BorderRadius.circular(16),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    c['image']!,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) {
                                      return Icon(
                                        Icons.broken_image_outlined,
                                        color: Colors.orange.shade700,
                                        size: 36,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                c['label']!,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Popular Shops title ────────────────────────────────
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppConstants.popularShops,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Popular shops horizontal scroll ────────────────────
                  // FIX: increased height from 140 → 155 to fit image + 2-line name + time
                  SizedBox(
                    height: 155,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 12),
                      itemCount: _shops.length,
                      itemBuilder: (_, i) {
                        final s = _shops[i];
                        return SizedBox(
                          width: 100,
                          // FIX: SizedBox + Column mainAxisSize.min
                          // stops the bottom overflow
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(16),
                                  border: Border.all(
                                      color: kPink.withValues(alpha: 0.3)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      s['image']!,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.store,
                                          color: kPink,
                                          size: 44,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                s['name']!,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                s['time']!,
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Daily Essentials ───────────────────────────────────
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppConstants.dailyEssentials,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),

                  RestaurantCard(
                    name: 'Lucky Supermarket Sen Sok',
                    subtitle: 'Supermarket',
                    time: '15-40 min',
                    rating: 4.5,
                    isFreeDelivery: true,
                    discount: AppConstants.discountOff17,
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAtV7wUW0l62mmbcHx49fB8WTsvrKKP65aQA&s',
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  RestaurantCard(
                    name: 'Aeon MaxValu Supermarket (Toul...)',
                    subtitle: 'Supermarket',
                    time: '10-35 min',
                    rating: 4.3,
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpy52L4vPX3zzsTDFoP6foIcQNeYAIhDaiVQ&s',
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  RestaurantCard(
                    name: 'AEON',
                    subtitle: 'Convenience',
                    time: '5-30 min',
                    rating: 4.1,
                    discount: '\$2 off \$12',
                    imageUrl:
                        'https://companieslogo.com/img/orig/8267.T-a5b1f27a.png?t=1720244490',
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Grocery Header ────────────────────────────────────────────────────────────

class _GroceryHeader extends StatelessWidget {
  const _GroceryHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPink,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            children: [
              Row(
                children: const [
                  Icon(Icons.location_on_outlined,
                      color: Colors.white, size: 20),
                  SizedBox(width: 6),
                  // FIX: Expanded so the text never overflows the Row
                  Expanded(
                    child: Text(
                      'Selected location',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.favorite_border,
                      color: Colors.white, size: 24),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: AppConstants.searchGrocery,
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child:
                          Icon(Icons.tune, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
