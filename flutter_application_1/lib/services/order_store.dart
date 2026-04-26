import 'package:flutter/foundation.dart';

class CartItem {
  final String restaurant;
  final String name;
  final String description;
  final String priceLabel;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.restaurant,
    required this.name,
    required this.description,
    required this.priceLabel,
    required this.imageUrl,
    this.quantity = 1,
  });

  double get unitPrice {
    final match = RegExp(r'(\d+(?:\.\d+)?)').firstMatch(priceLabel);
    return double.tryParse(match?.group(1) ?? '') ?? 0;
  }

  double get totalPrice => unitPrice * quantity;
}

class OrderStore extends ChangeNotifier {
  OrderStore._();

  static final OrderStore instance = OrderStore._();

  final List<CartItem> _items = [];
  String promoCode = '';
  String paymentMethod = 'Cash on delivery';

  List<CartItem> get items => List.unmodifiable(_items);
  bool get isEmpty => _items.isEmpty;
  int get itemCount => _items.fold(0, (total, item) => total + item.quantity);
  double get subtotal =>
      _items.fold(0, (total, item) => total + item.totalPrice);
  double get deliveryFee => _items.isEmpty ? 0 : 1.25;
  double get discount =>
      promoCode.trim().toUpperCase() == 'TRYPANDA' ? 3.00 : 0;
  double get total =>
      (subtotal + deliveryFee - discount).clamp(0, double.infinity);

  void addItem({
    required String restaurant,
    required String name,
    required String description,
    required String priceLabel,
    required String imageUrl,
  }) {
    final index = _items.indexWhere(
      (item) => item.restaurant == restaurant && item.name == name,
    );

    if (index == -1) {
      _items.add(
        CartItem(
          restaurant: restaurant,
          name: name,
          description: description,
          priceLabel: priceLabel,
          imageUrl: imageUrl,
        ),
      );
    } else {
      _items[index].quantity++;
    }

    notifyListeners();
  }

  void increase(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decrease(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  void applyPromo(String code) {
    promoCode = code.trim().toUpperCase();
    notifyListeners();
  }

  void setPaymentMethod(String value) {
    paymentMethod = value;
    notifyListeners();
  }

  void clear() {
    _items.clear();
    promoCode = '';
    paymentMethod = 'Cash on delivery';
    notifyListeners();
  }
}
