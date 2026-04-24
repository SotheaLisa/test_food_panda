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
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Burger_King_2020.svg/960px-Burger_King_2020.svg.png',
      ),
      PandaPickItem(
        name: 'Pizza Hut',
        category: 'Pizza',
        price: 9.99,
        rating: 4.3,
        deliveryTime: '20-35 min',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/d/d9/Pizza_Hut_2025.png',
      ),
      PandaPickItem(
        name: 'KFC Cambodia',
        category: 'Chicken',
        price: 7.50,
        rating: 4.4,
        deliveryTime: '10-20 min',
        isFreeDelivery: true,
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSn8e34-qq2CZI8io0Y5_8wjP6sZAfxGa_6hg&s',
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
