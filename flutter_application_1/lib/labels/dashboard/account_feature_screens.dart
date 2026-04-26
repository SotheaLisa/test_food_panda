import 'package:flutter/material.dart';
import 'package:flutter_application_1/RestraurantCard widget/constants/color.dart';
import 'package:flutter_application_1/labels/dashboard/cart_screen.dart';
import 'package:flutter_application_1/labels/dashboard/search_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _FeatureScaffold(
      title: 'Orders',
      leadingIcon: Icons.close,
      actionIcon: Icons.shopping_bag_outlined,
      onActionPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CartScreen()),
      ),
      backgroundColor: const Color(0xFFEAF5FD),
      child: const _OrdersEmptyState(),
    );
  }
}

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  int _tabIndex = 0;
  int _modeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final showModeToggle = _tabIndex == 0;

    return _FeatureScaffold(
      title: 'Favourites',
      actionIcon: Icons.shopping_bag_outlined,
      onActionPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CartScreen()),
      ),
      child: Column(
        children: [
          const SizedBox(height: 4),
          _TopTabs(
            labels: const ['Restaurants', 'Shops'],
            selectedIndex: _tabIndex,
            onChanged: (index) => setState(() => _tabIndex = index),
          ),
          const Divider(height: 1),
          if (showModeToggle)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Row(
                children: [
                  _ModeChip(
                    label: 'Delivery',
                    isSelected: _modeIndex == 0,
                    onTap: () => setState(() => _modeIndex = 0),
                  ),
                  const SizedBox(width: 12),
                  _ModeChip(
                    label: 'Pick-up',
                    isSelected: _modeIndex == 1,
                    onTap: () => setState(() => _modeIndex = 1),
                  ),
                ],
              ),
            ),
          Expanded(
            child: _FavouritesEmptyState(
              onFindPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _FeatureScaffold(
      title: 'Addresses',
      child: _AddressesEmptyState(
        onAddPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add address form is not added yet.')),
          );
        },
      ),
    );
  }
}

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FeatureScaffold(
      title: 'Payment methods',
      child: _PaymentsEmptyState(),
    );
  }
}

class _FeatureScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final IconData leadingIcon;
  final IconData? actionIcon;
  final VoidCallback? onActionPressed;
  final Color backgroundColor;

  const _FeatureScaffold({
    required this.title,
    required this.child,
    this.leadingIcon = Icons.arrow_back,
    this.actionIcon,
    this.onActionPressed,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(leadingIcon, color: Colors.black, size: 30),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: actionIcon == null
            ? null
            : [
                IconButton(
                  icon: Icon(actionIcon, color: Colors.black87, size: 28),
                  onPressed: onActionPressed,
                ),
              ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade300),
        ),
      ),
      body: SafeArea(top: false, child: child),
    );
  }
}

class _OrdersEmptyState extends StatelessWidget {
  const _OrdersEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _BagIllustration(),
            SizedBox(height: 28),
            Text(
              'No orders yet',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Hungry? Place an order and it\'ll show here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavouritesEmptyState extends StatelessWidget {
  final VoidCallback onFindPressed;

  const _FavouritesEmptyState({required this.onFindPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _HeartIllustration(),
            const SizedBox(height: 28),
            const Text(
              'No favourites saved',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'To make ordering even faster, you\'ll find all your faves here. Just look for the heart icon!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 310,
              height: 52,
              child: ElevatedButton(
                onPressed: onFindPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPink,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Let\'s find some favourites',
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

class _AddressesEmptyState extends StatelessWidget {
  final VoidCallback onAddPressed;

  const _AddressesEmptyState({required this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _AddressIllustration(),
            const SizedBox(height: 28),
            const Text(
              'It\'s empty here',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'You haven\'t saved any address yet. Add New Address to get started',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 260,
              height: 52,
              child: ElevatedButton(
                onPressed: onAddPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPink,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Add New Address',
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

class _PaymentsEmptyState extends StatelessWidget {
  const _PaymentsEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _CardIllustration(),
            SizedBox(height: 28),
            Text(
              'It\'s empty here',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'You don\'t have any saved credit cards.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopTabs extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _TopTabs({
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: List.generate(labels.length, (index) {
          final selected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: selected ? Colors.black87 : Colors.black45,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    width: 64,
                    height: 5,
                    decoration: BoxDecoration(
                      color: selected ? Colors.black87 : Colors.transparent,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2E313B) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _BagIllustration extends StatelessWidget {
  const _BagIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 14,
            bottom: 18,
            child: Container(
              width: 54,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Center(
                child: Icon(Icons.pets, color: kPink, size: 30),
              ),
            ),
          ),
          Positioned(
            right: 26,
            child: Container(
              width: 108,
              height: 122,
              decoration: BoxDecoration(
                color: kPinkLight,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  '?',
                  style: TextStyle(
                    fontSize: 62,
                    fontWeight: FontWeight.w800,
                    color: kPink,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 49,
            top: 12,
            child: Row(
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPink, width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPink, width: 3),
                    borderRadius: BorderRadius.circular(20),
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

class _HeartIllustration extends StatelessWidget {
  const _HeartIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 170,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 12,
            child: Icon(Icons.pets, color: kPink, size: 48),
          ),
          Positioned(
            bottom: 0,
            child: Icon(Icons.favorite, size: 130, color: kPinkLight),
          ),
          Positioned(
            left: 34,
            top: 54,
            child: Icon(Icons.favorite, size: 22, color: kPink),
          ),
        ],
      ),
    );
  }
}

class _AddressIllustration extends StatelessWidget {
  const _AddressIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 170,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 10,
            child: Transform.rotate(
              angle: -0.08,
              child: Container(
                width: 168,
                height: 96,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF5FD),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 18,
                      top: 22,
                      child: Container(
                        width: 54,
                        height: 34,
                        color: const Color(0xFF9EDCFD),
                      ),
                    ),
                    Positioned(
                      right: 18,
                      bottom: 18,
                      child: Container(
                        width: 68,
                        height: 42,
                        color: const Color(0xFFB9F0C6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            left: 14,
            bottom: 52,
            child: Icon(Icons.pets, color: kPink, size: 48),
          ),
          Positioned(
            top: 6,
            child: Icon(Icons.location_on, size: 112, color: kPink),
          ),
        ],
      ),
    );
  }
}

class _CardIllustration extends StatelessWidget {
  const _CardIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 18,
            top: 18,
            child: Container(
              width: 134,
              height: 76,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Center(
                child: Icon(Icons.credit_card, size: 44, color: Colors.black38),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 18,
            child: Icon(
              Icons.remove_circle_outline,
              color: Colors.grey.shade400,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
