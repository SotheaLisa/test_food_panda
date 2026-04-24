import 'package:flutter/material.dart';
import 'package:flutter_application_1/RestraurantCard widget/constants/color.dart';
import 'package:flutter_application_1/etc/constant.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const String _keyboardImageUrl =
      'https://beconnected.esafety.gov.au/pluginfile.php/86778/mod_resource/content/2/images/BC%203%20-%202a.png';

  static const List<Map<String, String>> _browseCategories = [
    {
      'label': 'Khmer New\nYear',
      'image':
          'https://static.vecteezy.com/system/resources/thumbnails/043/030/930/small/happy-khmer-new-year-vector.jpg',
    },
    {
      'label': 'Groceries',
      'image':
          'https://i.pinimg.com/1200x/60/c7/b3/60c7b3e11b79c1529b8741048f526b9d.jpg',
    },
    {
      'label': 'Convenience',
      'image':
          'https://i.pinimg.com/1200x/37/58/fd/3758fd8c93654ec516d0635134a076d2.jpg',
    },
    {
      'label': 'Beverages\n& Alcohol',
      'image':
          'https://i.pinimg.com/736x/86/2d/31/862d311a95bdcd29f191d14fb2cbb780.jpg',
    },
    {
      'label': 'Bakery',
      'image':
          'https://i.pinimg.com/1200x/3f/29/6f/3f296f9a562dfc4ec090de048f67b59b.jpg',
    },
  ];

  static const List<Map<String, String>> _popularShops = [
    {
      'name': 'Chip Mong\nSupermarket...',
      'time': '15-45 min',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqWb3y6VEA-huZg6U1MWrGJElHtyM4UsEoPA&s',
    },
    {
      'name': 'Lucky\nSupermarket',
      'time': '25-50 min',
      'image':
          'https://www.dfilucky.com/logo.png',
    },
    {
      'name': 'AEON',
      'time': '5-30 min',
      'image':
          'https://yt3.googleusercontent.com/-GOuQcQWIOzYibpMEO9kYZzKhqergcwHThY4-oQvG4MK27HWHuMpBtFkRt7rluGiFsvuJAeKvA=s900-c-k-c0x00ffffff-no-rj',
    },
    {
      'name': 'Aeon MaxValu\nSupermarket...',
      'time': '10-35 min',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpy52L4vPX3zzsTDFoP6foIcQNeYAIhDaiVQ&s',
    },
  ];

  static const List<String> _popularSearches = [
    'pharmacy',
    'aeon',
    'lucky super market',
    'decathlon',
    'flower',
    'pizza',
    'chip mong super market',
    'condom',
    'foodmate',
    'fruit',
  ];

  static const List<Map<String, Object>> _allResults = [
    {
      'name': 'Lucky Supermarket',
      'category': 'Grocery',
      'time': '15-40 min',
      'rating': 4.5,
      'image':
          'https://www.dfilucky.com/logo.png'
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
          'https://yt3.googleusercontent.com/-GOuQcQWIOzYibpMEO9kYZzKhqergcwHThY4-oQvG4MK27HWHuMpBtFkRt7rluGiFsvuJAeKvA=s900-c-k-c0x00ffffff-no-rj'
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

  static const List<List<String>> _letterRows = [
    ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
    ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'],
    ['z', 'x', 'c', 'v', 'b', 'n', 'm'],
  ];

  final TextEditingController _controller = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_handleFocusChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _searchFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_handleFocusChange);
    _searchFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {});
    }
  }

  void _setQuery(String value) {
    _controller
      ..text = value
      ..selection = TextSelection.collapsed(offset: value.length);
    setState(() => _query = value);
  }

  void _appendCharacter(String value) {
    _setQuery('$_query$value');
    _searchFocusNode.requestFocus();
  }

  void _addSpace() {
    if (_query.isEmpty || _query.endsWith(' ')) {
      return;
    }
    _setQuery('$_query ');
    _searchFocusNode.requestFocus();
  }

  void _backspace() {
    if (_query.isEmpty) {
      return;
    }
    _setQuery(_query.substring(0, _query.length - 1));
    _searchFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final showKeyboard = _searchFocusNode.hasFocus;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: showKeyboard ? 260 : 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 28,
                            ),
                            onPressed: () => Navigator.maybePop(context),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextField(
                                readOnly: true,
                                autofocus: true,
                                focusNode: _searchFocusNode,
                                controller: _controller,
                                onTap: () => _searchFocusNode.requestFocus(),
                                decoration: InputDecoration(
                                  hintText: AppConstants.searchGrocery,
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey.shade500,
                                  ),
                                  suffixIcon: _query.isNotEmpty
                                      ? IconButton(
                                          icon: const Icon(Icons.close, size: 18),
                                          color: Colors.grey,
                                          onPressed: () => _setQuery(''),
                                        )
                                      : null,
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _query.isEmpty
                          ? _PopularSearches(
                              searches: _popularSearches,
                              categories: _browseCategories,
                              popularShops: _popularShops,
                              onSelected: (value) {
                                _setQuery(value);
                                _searchFocusNode.requestFocus();
                              },
                            )
                          : _SearchResults(
                              query: _query,
                              results: _allResults,
                            ),
                    ),
                  ],
                ),
              ),
              if (showKeyboard)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _CustomKeyboard(
                    backgroundImageUrl: _keyboardImageUrl,
                    rows: _letterRows,
                    onLetterTap: _appendCharacter,
                    onBackspace: _backspace,
                    onSpace: _addSpace,
                    onDone: () => FocusScope.of(context).unfocus(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PopularSearches extends StatelessWidget {
  final List<String> searches;
  final List<Map<String, String>> categories;
  final List<Map<String, String>> popularShops;
  final ValueChanged<String> onSelected;

  const _PopularSearches({
    required this.searches,
    required this.categories,
    required this.popularShops,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular searches',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: searches
                .map(
                  (label) => InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () => onSelected(label),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 126,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) {
                final item = categories[i];
                return SizedBox(
                  width: 84,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF4E7),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            item['image']!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.image_outlined,
                                color: Colors.orange,
                                size: 30,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['label']!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 26),
          const Text(
            'Popular Shops',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 158,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: popularShops.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) {
                final shop = popularShops[i];
                return SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: kPink.withValues(alpha: 0.30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              shop['image']!,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.store,
                                  color: kPink,
                                  size: 40,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        shop['name']!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        shop['time']!,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
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

class _CustomKeyboard extends StatelessWidget {
  final String backgroundImageUrl;
  final List<List<String>> rows;
  final ValueChanged<String> onLetterTap;
  final VoidCallback onBackspace;
  final VoidCallback onSpace;
  final VoidCallback onDone;

  const _CustomKeyboard({
    required this.backgroundImageUrl,
    required this.rows,
    required this.onLetterTap,
    required this.onBackspace,
    required this.onSpace,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: const Color(0xFFE9EDF5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.22,
            child: Image.network(
              backgroundImageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox.shrink();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
            child: Column(
              children: [
                for (final row in rows) ...[
                  Expanded(
                    child: Row(
                      children: row
                          .map(
                            (letter) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: _KeyboardKey(
                                  label: letter,
                                  onTap: () => onLetterTap(letter),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 72,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: _KeyboardKey(
                            label: '123',
                            backgroundColor: const Color(0xFFB7BDC8),
                            onTap: () {},
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: _KeyboardKey(
                            label: 'space',
                            onTap: onSpace,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 72,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: _KeyboardKey(
                            icon: Icons.backspace_outlined,
                            backgroundColor: const Color(0xFFB7BDC8),
                            onTap: onBackspace,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 84,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: _KeyboardKey(
                            label: 'done',
                            backgroundColor: const Color(0xFFB7BDC8),
                            onTap: onDone,
                          ),
                        ),
                      ),
                    ],
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

class _KeyboardKey extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  const _KeyboardKey({
    this.label,
    this.icon,
    this.backgroundColor = Colors.white,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Center(
          child: icon != null
              ? Icon(icon, color: Colors.black87, size: 22)
              : Text(
                  label ?? '',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
