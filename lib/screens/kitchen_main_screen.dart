import 'package:flutter/material.dart';
import '../models/items.dart';
import '../models/orders.dart';
import '../models/requests.dart';
import '../widgets/item_dialog.dart';
import '../widgets/order_details_dialog.dart';

class KitchenScreen extends StatefulWidget {
  @override
  _KitchenScreenState createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {
  List<Item> _items = [];
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    _loadDummyOrders();
  }

  void _loadDummyOrders() {
    _orders = [
      Order(
        id: '1',
        tableNumber: 1,
        status: 'Pending',
        requests: [
          Request(item: Item(id: '1', name: 'Pizza', description: 'Cheese pizza', price: 10.0, code: 'PIZ001'), quantity: 1, notes: 'No onions'),
          Request(item: Item(id: '2', name: 'Burger', description: 'Beef burger', price: 8.0, code: 'BUR001'), quantity: 2, notes: 'Extra ketchup'),
        ],
      ),
      Order(
        id: '2',
        tableNumber: 2,
        status: 'In Progress',
        requests: [
          Request(item: Item(id: '3', name: 'Salad', description: 'Fresh salad', price: 6.0, code: 'SAL001'), quantity: 1, notes: 'No dressing'),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitchen Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome Chef',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _showOrderDetails(context, _orders[index]);
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Table ${_orders[index].tableNumber}',
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Text('Status: ${_orders[index].status}'),
                          SizedBox(height: 8.0),
                          Text(
                            'Items:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _orders[index].requests.map((request) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  children: [
                                    Expanded(child: Text('${request.item.name} x${request.quantity}')),
                                    SizedBox(width: 16.0),
                                    Text(request.notes),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ItemDialog(
          onAddItem: _addItemToList,
        );
      },
    );
  }

  void _addItemToList(Item item) {
    setState(() {
      _items.add(item);
    });
  }

  void _showOrderDetails(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OrderDetailsDialog(
          order: order,
          onSave: (String newStatus) {
            setState(() {
              order.status = newStatus;
            });
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
