class Item {
  final String id;
  final String name;
  final String description;
  final double price;
  final String code;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'code': code,
    };
  }

  factory Item.fromMap(Map<dynamic, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      code: map['code'],
    );
  }
}
