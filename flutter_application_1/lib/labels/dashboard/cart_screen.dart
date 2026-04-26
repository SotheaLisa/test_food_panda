import 'package:flutter/material.dart';
import 'package:flutter_application_1/RestraurantCard widget/constants/color.dart';
import 'package:flutter_application_1/etc/constant.dart';
import 'package:flutter_application_1/labels/dashboard/checkout_screen.dart';
import 'package:flutter_application_1/labels/dashboard/search_screen.dart';
import 'package:flutter_application_1/services/order_store.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _promoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _promoController.text = OrderStore.instance.promoCode;
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

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
            elevation: 0,
            leadingWidth: 56,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
              onPressed: () => Navigator.maybePop(context),
            ),
            titleSpacing: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Review order',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  store.isEmpty
                      ? AppConstants.deliverTo
                      : 'Deliver to: Le Roof Cafe Phnom Penh',
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(height: 1, color: Colors.grey.shade300),
            ),
          ),
          body: SafeArea(
            top: false,
            child: store.isEmpty
                ? const _EmptyCart()
                : _FilledCart(store: store),
          ),
          bottomNavigationBar: store.isEmpty
              ? null
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CheckoutScreen(),
                        ),
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
                        'Choose payment - \$${store.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class _FilledCart extends StatelessWidget {
  final OrderStore store;

  const _FilledCart({required this.store});

  @override
  Widget build(BuildContext context) {
    final promoController = context
        .findAncestorStateOfType<_CartScreenState>()!
        ._promoController;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
      children: [
        Text(
          store.items.first.restaurant,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        ...store.items.map((item) => _CartItemRow(item: item)),
        const SizedBox(height: 20),
        const Text(
          'Promo code',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: promoController,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: 'Try TRYPANDA',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => store.applyPromo(promoController.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPink,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Apply'),
            ),
          ],
        ),
        if (store.discount > 0) ...[
          const SizedBox(height: 8),
          const Text(
            'Promo applied: TRYPANDA',
            style: TextStyle(color: kPink, fontWeight: FontWeight.w700),
          ),
        ],
        const SizedBox(height: 22),
        _TotalRow(label: 'Subtotal', value: store.subtotal),
        _TotalRow(label: 'Delivery fee', value: store.deliveryFee),
        _TotalRow(label: 'Discount', value: -store.discount),
        const Divider(height: 24),
        _TotalRow(label: 'Total', value: store.total, isTotal: true),
      ],
    );
  }
}

class _CartItemRow extends StatelessWidget {
  final CartItem item;

  const _CartItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final store = OrderStore.instance;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 64,
                height: 64,
                color: kPinkLight,
                child: const Icon(Icons.fastfood, color: kPink),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 3),
                Text(
                  item.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(height: 5),
                Text(
                  '\$${item.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: kPink,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          _QuantityButton(
            icon: Icons.remove,
            onTap: () => store.decrease(item),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '${item.quantity}',
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          _QuantityButton(icon: Icons.add, onTap: () => store.increase(item)),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(
          color: kPinkLight,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: kPink, size: 18),
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isTotal;

  const _TotalRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final amount = value < 0
        ? '-\$${value.abs().toStringAsFixed(2)}'
        : '\$${value.toStringAsFixed(2)}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 18 : 14,
                fontWeight: isTotal ? FontWeight.w800 : FontWeight.w500,
                color: isTotal ? Colors.black87 : Colors.black54,
              ),
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: FontWeight.w800,
              color: isTotal ? kPink : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://i.pinimg.com/736x/ae/42/5e/ae425e541608367ab037cf232ac2ae79.jpg',
                width: 220,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox(
                  width: 220,
                  height: 220,
                  child: Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              AppConstants.hungryTitle,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              AppConstants.emptyCartSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 26),
            SizedBox(
              width: 126,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchScreen()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPink,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  AppConstants.browseButton,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
