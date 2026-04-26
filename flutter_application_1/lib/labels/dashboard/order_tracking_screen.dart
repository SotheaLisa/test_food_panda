import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/RestraurantCard widget/constants/color.dart';
import 'package:flutter_application_1/labels/dashboard/rate_order_screen.dart';
import 'package:flutter_application_1/services/order_store.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  late final Timer _timer;
  double _progress = 0.18;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!mounted) return;
      setState(() {
        _progress = (_progress + 0.14).clamp(0, 1);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delivered = _progress >= 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Track order',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _MapPreview(progress: _progress)),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    delivered ? 'Delivered' : 'Your rider is on the way',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    delivered
                        ? 'Enjoy your order and tell us how it went.'
                        : 'Estimated arrival: ${(18 - (_progress * 12)).ceil()} min',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 14),
                  LinearProgressIndicator(
                    value: _progress,
                    minHeight: 8,
                    color: kPink,
                    backgroundColor: kPinkLight,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  const SizedBox(height: 16),
                  _StatusRow(
                    icon: Icons.receipt_long,
                    title: 'Order confirmed',
                    active: _progress >= 0.15,
                  ),
                  _StatusRow(
                    icon: Icons.restaurant,
                    title: 'Preparing food',
                    active: _progress >= 0.35,
                  ),
                  _StatusRow(
                    icon: Icons.delivery_dining,
                    title: 'Rider picked up',
                    active: _progress >= 0.65,
                  ),
                  _StatusRow(
                    icon: Icons.home_outlined,
                    title: 'Delivered',
                    active: delivered,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: delivered
                          ? () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RateOrderScreen(),
                              ),
                            )
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPink,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.shade300,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Rate experience',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPreview extends StatelessWidget {
  final double progress;

  const _MapPreview({required this.progress});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        final riderX = 44 + (w - 118) * progress;
        final riderY = h * (0.72 - 0.38 * progress);

        return Stack(
          fit: StackFit.expand,
          children: [
            Container(color: const Color(0xFFEAF5FD)),
            Positioned(
              top: h * 0.2,
              left: -40,
              right: -40,
              child: Transform.rotate(
                angle: -0.22,
                child: Container(height: 26, color: Colors.white),
              ),
            ),
            Positioned(
              top: h * 0.54,
              left: -30,
              right: -30,
              child: Transform.rotate(
                angle: 0.18,
                child: Container(height: 32, color: Colors.white),
              ),
            ),
            Positioned(
              left: 34,
              bottom: 44,
              child: _MapPin(
                color: Colors.black87,
                icon: Icons.restaurant,
                label: OrderStore.instance.items.isEmpty
                    ? 'Restaurant'
                    : OrderStore.instance.items.first.restaurant,
              ),
            ),
            const Positioned(
              right: 28,
              top: 52,
              child: _MapPin(
                color: kPink,
                icon: Icons.home_outlined,
                label: 'You',
              ),
            ),
            Positioned(
              left: riderX,
              top: riderY,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: kPink,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: kPink.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.delivery_dining,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MapPin extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;

  const _MapPin({required this.color, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 120),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool active;

  const _StatusRow({
    required this.icon,
    required this.title,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: active ? kPink : Colors.grey, size: 20),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: active ? Colors.black87 : Colors.black45,
              fontWeight: active ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
