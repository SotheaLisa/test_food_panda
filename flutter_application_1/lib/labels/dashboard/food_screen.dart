import 'package:flutter/material.dart';
import 'package:flutter_application_1/RestraurantCard widget/constants/color.dart';
import 'package:flutter_application_1/etc/constant.dart';
import 'package:flutter_application_1/pages/model/exclusive_panda/exclusive_helper.dart';
import 'package:flutter_application_1/pages/model/panda_pick_m/panda_pick_helper.dart';

import 'detail_screen.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _FoodHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HeroBanner(),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 20),
                      _CategoryIconRow(),
                      Divider(height: 32, indent: 16, endIndent: 16),
                      _FoodTypeGrid(),
                      SizedBox(height: 20),
                      _PromoCardsRow(),
                      SizedBox(height: 28),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "🐼 Panda Picks",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 12),
                      _PandaPicksList(),
                      SizedBox(height: 28),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "⭐ Exclusive Deals",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 12),
                      _ExclusiveList(),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _FoodHeader extends StatelessWidget {
  const _FoodHeader();

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
              // FIX: Expanded on text so it never overflows the row
              Row(
                children: const [
                  Icon(Icons.location_on_outlined,
                      color: Colors.white, size: 20),
                  SizedBox(width: 6),
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
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: AppConstants.searchFood,
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.grey, fontSize: 14),
                        ),
                      ),
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

// ── Hero Banner ───────────────────────────────────────────────────────────────

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPink,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // FIX: Expanded so text column never pushes the image off screen
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConstants.heroBannerText,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.3),
                ),
                SizedBox(height: 10),
                // FIX: mainAxisSize.min so the Row only takes needed space
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppConstants.startOrdering,
                        style:
                            TextStyle(color: Colors.white, fontSize: 13)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 12),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 110,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.pink.shade300,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.local_pizza,
                color: Colors.white, size: 50),
          ),
        ],
      ),
    );
  }
}

// ── Category Icons ────────────────────────────────────────────────────────────
class _CategoryIconRow extends StatelessWidget {
  const _CategoryIconRow();

  static const List<Map<String, Object>> _cats = [
    {
      'label': 'Offers',
      'icon': Icons.percent,
    },
    {
      'label': 'Chinese\nFood',
      'image':
          'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDI0LTA3L3Jhd3BpeGVsX29mZmljZV8zMl8zZF9yZWFsaXN0aWNfb2ZfYV9jaGluZXNlX3NodW1haV9mbGF0X2xheV92aV9kYWRhYWM1OC1iZmUzLTQyMzItYTNkNy04NWM3NWZkNjc1YTQucG5n.png',
    },
    {
      'label': 'New\nrestaurants',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqq5w7Vj3st2zOkK6Yx57kAvh1PQ3axHQkDg&s',
    },
    {
      'label': 'Lucky',
      'image': 'https://www.dfilucky.com/logo.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: _cats.map((c) {
          final isFirst = c['label'] == 'Offers';
          final imageUrl = c['image'] as String?;
          final iconData = c['icon'] as IconData?;

          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: imageUrl == null
                        ? (isFirst ? kPink : kPinkLight)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              );
                            },
                          ),
                        )
                      : Icon(
                          iconData,
                          color: isFirst ? Colors.white : kPink,
                          size: 26,
                        ),
                ),
                const SizedBox(height: 6),
                Text(
                  c['label'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}


// ── Food Type Grid ────────────────────────────────────────────────────────────
class _FoodTypeGrid extends StatelessWidget {
  const _FoodTypeGrid();

  static const _types = [
    {
      'label': 'Pizza',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSA_HV4uhKwH_y2vk0XoPRQzZrhzVXbQrvpg&s'
    },
    {
      'label': 'Korean',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7AOachJFbYRT9MNE20zvZL2V2aWIxBRxI7w&s'
    },
    {
      'label': 'Tea & Coffee',
      'image':
          'https://t4.ftcdn.net/jpg/06/61/30/11/360_F_661301175_93tzscJly2aU5aMIvprt9Dn9CCL53Fvt.jpg'
    },
    {
      'label': 'Burgers',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScYtEyzbggkdu_V17OP3zgM5xv96YiI7vqwg&s'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: _types.map((t) {
          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      t['image'] as String,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.broken_image,
                          color: Colors.grey.shade600,
                          size: 32,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  t['label'] as String,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}


// ── Promo Cards ───────────────────────────────────────────────────────────────

class _PromoCardsRow extends StatelessWidget {
  const _PromoCardsRow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _PromoCard(
              headerBg: Colors.black87,
              headerText: 'Free delivery',
              discount: '70% off*',
              subtitle: 'your 1st order',
              code: AppConstants.promoTryPanda,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _PromoCard(
              headerBg: Color(0xFF006D77),
              headerText: 'ABA PAY',
              discount: 'Get\n70% off*',
              subtitle: 'with ABA PAY',
              code: AppConstants.promoAbaPay,
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  final Color headerBg;
  final String headerText;
  final String discount;
  final String subtitle;
  final String code;

  const _PromoCard({
    required this.headerBg,
    required this.headerText,
    required this.discount,
    required this.subtitle,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: kPinkLight,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: headerBg,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text(
                headerText,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // FIX: add right: 10 so text doesn't bleed off card edge
          Positioned(
            top: 36,
            left: 10,
            right: 10,
            child: Text(
              discount,
              style: const TextStyle(
                  color: kPink,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: 1.1),
            ),
          ),
          Positioned(
            top: 88,
            left: 10,
            right: 10,
            child: Text(
              subtitle,
              style:
                  const TextStyle(color: Colors.black54, fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: kPink,
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('code ',
                      style: TextStyle(
                          color: Colors.white, fontSize: 10)),
                  Text(code,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Panda Picks List ──────────────────────────────────────────────────────────

class _PandaPicksList extends StatelessWidget {
  const _PandaPicksList();

  @override
  Widget build(BuildContext context) {
    final picks = PandaPickHelper.getPandaPicks();
    return SizedBox(
      height: 128,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: picks.length,
        itemBuilder: (_, i) {
          final p = picks[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => DetailScreen(title: p.name)),
            ),
            child: Container(
              width: 108,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              // FIX: use padding + mainAxisSize.min so Column fits the box
              padding: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                        color: kPinkLight, shape: BoxShape.circle),
                    child:
                        const Icon(Icons.fastfood, color: kPink, size: 22),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    p.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    p.deliveryTime,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 9),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Exclusive List ────────────────────────────────────────────────────────────

class _ExclusiveList extends StatelessWidget {
  const _ExclusiveList();

  @override
  Widget build(BuildContext context) {
    final items = ExclusiveHelper.getExclusiveItems();
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 1, indent: 16, endIndent: 16),
      itemBuilder: (_, i) {
        final item = items[i];
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
                color: kPinkLight, shape: BoxShape.circle),
            child: const Icon(Icons.star, color: kPink, size: 26),
          ),
          title: Text(
            item.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            item.restaurant,
            style: const TextStyle(color: Colors.grey, fontSize: 11),
            overflow: TextOverflow.ellipsis,
          ),
          // FIX: mainAxisSize.min prevents trailing Column from overflowing
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 12),
                  const SizedBox(width: 2),
                  Text(item.rating.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 11)),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '\$${item.price.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: kPink,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
            ],
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DetailScreen(title: item.name)),
          ),
        );
      },
    );
  }
}