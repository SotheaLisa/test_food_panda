import 'package:flutter/material.dart';
import 'package:flutter_application_1/RestraurantCard widget/constants/color.dart';
import 'package:flutter_application_1/components/restaurant.dart';
import 'package:flutter_application_1/etc/constant.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

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

  static const List<Map<String, Object>> _allResults = [
    {
      'name': 'Lucky Supermarket',
      'category': 'Grocery',
      'time': '15-40 min',
      'rating': 4.5,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAtV7wUW0l62mmbcHx49fB8WTsvrKKP65aQA&s'
    },
    {
      'name': 'Chip Mong Supermarket',
      'category': 'Grocery',
      'time': '15-45 min',
      'rating': 4.4,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqWb3y6VEA-huZg6U1MWrGJElHtyM4UsEoPA&s'
    },
    {
      'name': 'AEON',
      'category': 'Supermarket',
      'time': '5-30 min',
      'rating': 4.1,
      'image':
          'https://companieslogo.com/img/orig/8267.T-a5b1f27a.png?t=1720244490'
    },
    {
      'name': 'Aeon MaxValu',
      'category': 'Supermarket',
      'time': '10-35 min',
      'rating': 4.3,
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpy52L4vPX3zzsTDFoP6foIcQNeYAIhDaiVQ&s'
    },
    {
      'name': 'Bakery',
      'category': 'Bakery',
      'time': '20-30 min',
      'rating': 4.2,
      'image':
          'https://i.pinimg.com/1200x/3f/29/6f/3f296f9a562dfc4ec090de048f67b59b.jpg'
    },
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _controller,
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: AppConstants.searchGrocery,
                    hintStyle:
                        TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    prefixIcon:
                        Icon(Icons.search, color: Colors.grey.shade500),
                    suffixIcon: _query.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            color: Colors.grey,
                            onPressed: () {
                              _controller.clear();
                              setState(() => _query = '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _query.isEmpty
                  ? _SearchHome(
                      categories: _categories,
                      shops: _shops,
                    )
                  : _SearchResults(query: _query, results: _allResults),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchHome extends StatelessWidget {
  final List<Map<String, String>> categories;
  final List<Map<String, String>> shops;

  const _SearchHome({
    required this.categories,
    required this.shops,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const _SectionTitle('Browse categories'),
          const SizedBox(height: 12),
          SizedBox(
            height: 125,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemCount: categories.length,
              itemBuilder: (_, i) {
                final c = categories[i];
                return SizedBox(
                  width: 80,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            c['image']!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
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
          const _SectionTitle(AppConstants.popularShops),
          const SizedBox(height: 12),
          SizedBox(
            height: 155,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemCount: shops.length,
              itemBuilder: (_, i) {
                final s = shops[i];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          DetailScreen(title: s['name']!.replaceAll('\n', ' ')),
                    ),
                  ),
                  child: SizedBox(
                    width: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border:
                                Border.all(color: kPink.withValues(alpha: 0.3)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                s['image']!,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
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
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          s['time']!,
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          const _SectionTitle(AppConstants.dailyEssentials),
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
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const DetailScreen(
                  title: 'Lucky Supermarket Sen Sok',
                ),
              ),
            ),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          RestaurantCard(
            name: 'Aeon MaxValu Supermarket (Toul...)',
            subtitle: 'Supermarket',
            time: '10-35 min',
            rating: 4.3,
            imageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpy52L4vPX3zzsTDFoP6foIcQNeYAIhDaiVQ&s',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const DetailScreen(
                  title: 'Aeon MaxValu Supermarket',
                ),
              ),
            ),
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
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const DetailScreen(title: 'AEON'),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  final String query;
  final List<Map<String, Object>> results;

  const _SearchResults({
    required this.query,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = results
        .where(
          (r) =>
              (r['name'] as String).toLowerCase().contains(query.toLowerCase()) ||
              (r['category'] as String)
                  .toLowerCase()
                  .contains(query.toLowerCase()),
        )
        .toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'No results for "$query"',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try a different keyword',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: filtered.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 1, indent: 16, endIndent: 16),
      itemBuilder: (_, i) {
        final item = filtered[i];
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: kPinkLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item['image'] as String,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.store, color: kPink, size: 28);
                },
              ),
            ),
          ),
          title: Text(
            item['name'] as String,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 12),
              const SizedBox(width: 3),
              Expanded(
                child: Text(
                  '${item['rating']}  •  ${item['category']}  •  ${item['time']}',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing:
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreen(title: item['name'] as String),
            ),
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
