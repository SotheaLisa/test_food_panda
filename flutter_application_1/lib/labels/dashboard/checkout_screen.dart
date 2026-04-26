import 'package:flutter/material.dart';
import 'package:flutter_application_1/RestraurantCard widget/constants/color.dart';
import 'package:flutter_application_1/labels/dashboard/order_tracking_screen.dart';
import 'package:flutter_application_1/services/order_store.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  static const _methods = [
    ('Cash on delivery', Icons.payments_outlined),
    ('ABA PAY', Icons.account_balance_wallet_outlined),
    ('Credit or debit card', Icons.credit_card),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: OrderStore.instance,
      builder: (context, _) {
        final store = OrderStore.instance;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text(
              'Payment',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Delivery address',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              const _AddressCard(),
              const SizedBox(height: 24),
              const Text(
                'Choose payment method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              ..._methods.map(
                (method) => _PaymentTile(
                  title: method.$1,
                  icon: method.$2,
                  selected: store.paymentMethod == method.$1,
                  onTap: () => store.setPaymentMethod(method.$1),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Order summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              _SummaryLine(label: 'Items', value: store.itemCount.toString()),
              _SummaryLine(
                label: 'Subtotal',
                value: '\$${store.subtotal.toStringAsFixed(2)}',
              ),
              _SummaryLine(
                label: 'Delivery fee',
                value: '\$${store.deliveryFee.toStringAsFixed(2)}',
              ),
              if (store.discount > 0)
                _SummaryLine(
                  label: 'Promo discount',
                  value: '-\$${store.discount.toStringAsFixed(2)}',
                ),
              const Divider(height: 28),
              _SummaryLine(
                label: 'Total',
                value: '\$${store.total.toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: store.isEmpty
                    ? null
                    : () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrderTrackingScreen(),
                        ),
                      ),
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
                  'Confirm order',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          Icon(Icons.location_on_outlined, color: kPink),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Le Roof Cafe Phnom Penh\nStreet 51, Phnom Penh',
              style: TextStyle(fontWeight: FontWeight.w700, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentTile({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: selected ? kPink : Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(icon, color: selected ? kPink : Colors.black54),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? kPink : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryLine({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isTotal ? Colors.black87 : Colors.black54,
                fontSize: isTotal ? 18 : 14,
                fontWeight: isTotal ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? kPink : Colors.black87,
              fontSize: isTotal ? 18 : 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
