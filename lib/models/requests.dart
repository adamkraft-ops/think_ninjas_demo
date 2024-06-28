import 'items.dart';

class Request {
  final Item item;
  final String notes;
  final int quantity;

  Request({
    required this.item,
    required this.notes,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'item': item.toMap(),
      'notes': notes,
      'quantity': quantity,
    };
  }

  factory Request.fromMap(Map<dynamic, dynamic> map) {
    return Request(
      item: Item.fromMap(map['item']),
      notes: map['notes'],
      quantity: map['quantity'],
    );
  }
}
