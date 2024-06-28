import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/items.dart';
import '../models/requests.dart';
import '../models/orders.dart' as my_model;
import '../services/items.dart';
import '../services/orders.dart';
import '../widgets/item_dialog.dart';
import '../widgets/order_dialog.dart';

class WaiterScreen extends StatefulWidget {
  @override
  _WaiterScreenState createState() => _WaiterScreenState();
}

class _WaiterScreenState extends State<WaiterScreen> {
  List<Request> _requests = [];
  final Uuid _uuid = Uuid();

  @override
  void initState() {
    super.initState();
  }

  void _addItem(Item item) async {
    try {
      await ItemService.saveItem(item);
      _showDialog(context, true, 'Item added successfully');
    } catch (e) {
      _showDialog(context, false, 'Failed to add item');
    }
  }

  void _addRequest(Request request) {
    setState(() {
      _requests.add(request);
    });
  }

  void _addOrder(my_model.Order order) async {
    try {
      await OrderService.saveOrder(order);
      _showDialog(context, true, 'Order added successfully');
      setState(() {
        _requests.clear();
      });
    } catch (e) {
      _showDialog(context, false, 'Failed to add order');
    }
  }

  void _removeOrder(String orderId) async {
    try {
      await OrderService.deleteOrder(orderId);
      _showDialog(context, true, 'Order removed successfully');
    } catch (e) {
      _showDialog(context, false, 'Failed to remove order');
    }
  }

  void _showDialog(BuildContext context, bool isSuccess, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isSuccess ? Text('Success') : Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showItemDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ItemDialog(onAddItem: _addItem);
      },
    );
  }

  void _showOrderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OrderDialog(
          onAddRequest: _addRequest,
          onAddOrder: (List<Request> requests, int tableNumber) {
            my_model.Order newOrder = my_model.Order(
              id: _uuid.v4(),
              requests: requests,
              tableNumber: tableNumber,
              status: 'Pending',
            );
            _addOrder(newOrder);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Waitron'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _showItemDialog,
                child: Text('Menu+'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: _showOrderDialog,
                child: Text('Order+'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<List<Item>>(
              stream: ItemService.fetchItems(),
              builder: (context, snapshot) {
                bool showNoItems = false;

                Timer(Duration(seconds: 5), () {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    setState(() {
                      showNoItems = true;
                    });
                  }
                });

                if (snapshot.connectionState == ConnectionState.waiting) {

                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  if (showNoItems) {
                    return Center(child: Text('No items found.'));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                } else {

                  List<Item> items = snapshot.data!;
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(items[index].name),
                        subtitle: Text('Price: \$${items[index].price.toStringAsFixed(2)}'),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<my_model.Order>>(
              stream: OrderService.fetchOrders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No orders found.'));
                }
                List<my_model.Order> orders = snapshot.data!;
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Table ${orders[index].tableNumber} - Status: ${orders[index].status}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: orders[index].requests.map((request) {
                          return Text('${request.item.name} x${request.quantity} - ${request.notes}');
                        }).toList(),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeOrder(orders[index].id);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
