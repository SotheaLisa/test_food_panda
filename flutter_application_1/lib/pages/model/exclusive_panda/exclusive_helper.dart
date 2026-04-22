import 'exclusive_item.dart';

class ExclusiveHelper {
  static List<ExclusiveItem> getExclusiveItems() {
    return const [
      ExclusiveItem(
        name: 'Spicy Panda Burger',
        restaurant: 'Panda Kitchen',
        price: 8.99,
        rating: 4.8,
      ),
      ExclusiveItem(
        name: 'Dragon Roll Set',
        restaurant: 'Sushi World',
        price: 12.50,
        rating: 4.9,
      ),
      ExclusiveItem(
        name: 'Truffle Pizza',
        restaurant: 'La Pizzeria',
        price: 15.00,
        rating: 4.7,
      ),
      ExclusiveItem(
        name: 'Korean BBQ Bowl',
        restaurant: 'Seoul Garden',
        price: 10.99,
        rating: 4.6,
      ),
    ];
  }
}