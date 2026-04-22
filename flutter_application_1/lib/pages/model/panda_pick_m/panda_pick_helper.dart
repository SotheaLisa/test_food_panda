import 'panda_pick_item.dart';

class PandaPickHelper {
  static List<PandaPickItem> getPandaPicks() {
    return const [
      PandaPickItem(
        name: 'Burger King',
        category: 'Burgers',
        price: 5.99,
        rating: 4.5,
        deliveryTime: '15-25 min',
        isFreeDelivery: true,
      ),
      PandaPickItem(
        name: 'Pizza Hut',
        category: 'Pizza',
        price: 9.99,
        rating: 4.3,
        deliveryTime: '20-35 min',
      ),
      PandaPickItem(
        name: 'KFC Cambodia',
        category: 'Chicken',
        price: 7.50,
        rating: 4.4,
        deliveryTime: '10-20 min',
        isFreeDelivery: true,
      ),
      PandaPickItem(
        name: 'Subway',
        category: 'Sandwiches',
        price: 6.00,
        rating: 4.2,
        deliveryTime: '15-30 min',
      ),
    ];
  }
}
