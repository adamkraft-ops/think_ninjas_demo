import 'requests.dart';

class Order {
  final String id;
  final List<Request> requests;
  final int tableNumber;
  late final String status;

  Order({
    required this.id,
    required this.requests,
    required this.tableNumber,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'requests': requests.map((request) => request.toMap()).toList(),
      'tableNumber': tableNumber,
      'status': status,
    };
  }

  factory Order.fromMap(Map<dynamic, dynamic> map) {
    return Order(
      id: map['id'],
      requests: (map['requests'] as List<dynamic>).map((item) => Request.fromMap(item)).toList(),
      tableNumber: map['tableNumber'],
      status: map['status'],
    );
  }
}
