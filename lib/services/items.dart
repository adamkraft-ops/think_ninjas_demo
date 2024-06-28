import 'package:firebase_database/firebase_database.dart';
import '../models/items.dart';

class ItemService {
  static final DatabaseReference _itemRef = FirebaseDatabase.instance.ref().child('items');

  static Future<void> saveItem(Item item) async {
    await _itemRef.child(item.id).set(item.toMap());
  }

  static Stream<List<Item>> fetchItems() {
    return _itemRef.onValue.map((event) {
      final itemsMap = event.snapshot.value as Map<dynamic, dynamic>?;
      if (itemsMap != null) {
        return itemsMap.values.map((item) => Item.fromMap(item)).toList();
      } else {
        return [];
      }
    });
  }
}
