import 'package:flutter/material.dart';
import 'package:flutter_application_1/RestraurantCard widget/constants/color.dart';
import 'package:flutter_application_1/labels/dashboard/home_screen.dart';
import 'package:flutter_application_1/services/order_store.dart';

class RateOrderScreen extends StatefulWidget {
  const RateOrderScreen({super.key});

  @override
  State<RateOrderScreen> createState() => _RateOrderScreenState();
}

class _RateOrderScreenState extends State<RateOrderScreen> {
  int _rating = 5;
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = OrderStore.instance.items.isEmpty
        ? 'your order'
        : OrderStore.instance.items.first.restaurant;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Rate experience',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Container(
              width: 96,
              height: 96,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: kPinkLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: kPink, size: 54),
            ),
            const SizedBox(height: 24),
            const Text(
              'Order delivered',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              'How was your experience with $restaurant?',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54, fontSize: 15),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final value = index + 1;
                return IconButton(
                  onPressed: () => setState(() => _rating = value),
                  icon: Icon(
                    value <= _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 38,
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _noteController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Leave a comment',
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                OrderStore.instance.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPink,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Submit rating',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
