import 'package:flutter/material.dart';
import 'package:flutter_application_1/RestraurantCard widget/constants/color.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String time;
  final double rating;
  final bool isFreeDelivery;
  final String? discount;
  final String? imageUrl;
  final Color iconColor;
  final IconData icon;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;

  const RestaurantCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.time,
    required this.rating,
    this.isFreeDelivery = false,
    this.discount,
    this.imageUrl,
    this.iconColor = kPink,
    this.icon = Icons.store,
    this.onTap,
    this.onFavoriteTap,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: kPinkLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: imageUrl != null
                    ? Image.network(
                        imageUrl!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(icon, color: iconColor, size: 36);
                        },
                      )
                    : Icon(icon, color: iconColor, size: 36),
              ),
            ),
            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 13),
                      const SizedBox(width: 3),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.access_time,
                        color: Colors.grey,
                        size: 13,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  if (isFreeDelivery) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.delivery_dining, color: kPink, size: 13),
                        SizedBox(width: 4),
                        Text(
                          'Free for first order',
                          style: TextStyle(color: kPink, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                  if (discount != null) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: kPinkLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.discount_outlined,
                            color: kPink,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            discount!,
                            style: const TextStyle(
                              color: kPink,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (onTap != null) ...[
                    const SizedBox(height: 6),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View details',
                          style: TextStyle(
                            color: kPink,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 3),
                        Icon(Icons.arrow_forward_ios, color: kPink, size: 10),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Favorite
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? kPink : Colors.grey,
                size: 20,
              ),
              onPressed: onFavoriteTap,
            ),
          ],
        ),
      ),
    );
  }
}
