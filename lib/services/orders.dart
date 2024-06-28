import 'package:firebase_database/firebase_database.dart';
import '../models/orders.dart';

class OrderService {
  static final DatabaseReference _orderRef = FirebaseDatabase.instance.ref().child('orders');

  static Future<void> saveOrder(Order order) async {
    await _orderRef.child(order.id).set(order.toMap());
  }

  static Future<void> deleteOrder(String orderId) async {
    await _orderRef.child(orderId).remove();
  }

  static Stream<List<Order>> fetchOrders() {
    return _orderRef.onValue.map((event) {
      final ordersMap = event.snapshot.value as Map<dynamic, dynamic>?;
      if (ordersMap != null) {
        return ordersMap.values.map((order) => Order.fromMap(order)).toList();
      } else {
        return [];
      }
    });
  }
}
