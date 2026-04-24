import 'exclusive_item.dart';

class ExclusiveHelper {
  static List<ExclusiveItem> getExclusiveItems() {
    return const [
      ExclusiveItem(
        name: 'Spicy Panda Burger',
        restaurant: 'Panda Kitchen',
        price: 8.99,
        rating: 4.8,
        imageUrl:
            'https://static.vecteezy.com/system/resources/previews/027/145/412/non_2x/delicious-jalapeno-burger-isolated-on-transparent-background-png.png',
      ),
      ExclusiveItem(
        name: 'Dragon Roll Set',
        restaurant: 'Sushi World',
        price: 12.50,
        rating: 4.9,
        imageUrl:
            'https://png.pngtree.com/png-vector/20231121/ourmid/pngtree-dragon-rolls-a-ceramic-plate-png-image_10679575.png',
      ),
      ExclusiveItem(
        name: 'Truffle Pizza',
        restaurant: 'La Pizzeria',
        price: 15.00,
        rating: 4.7,
        imageUrl:
            'https://thumbs.dreamstime.com/b/pizza-truffle-truffles-ruccola-cheese-white-table-cloth-97193596.jpg',
      ),
      ExclusiveItem(
        name: 'Korean BBQ Bowl',
        restaurant: 'Seoul Garden',
        price: 10.99,
        rating: 4.6,
        imageUrl:
            'https://static.vecteezy.com/system/resources/thumbnails/036/409/436/small/ai-generated-savoring-korean-bbq-png.png',
      ),
    ];
  }
}
