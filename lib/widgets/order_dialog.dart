import 'package:flutter/material.dart';
import '../models/items.dart';
import '../models/requests.dart';
import '../models/orders.dart';
import '../services/items.dart';

class OrderDialog extends StatefulWidget {
  final Function(Request) onAddRequest;
  final Function(List<Request>, int) onAddOrder;

  OrderDialog({required this.onAddRequest, required this.onAddOrder});

  @override
  _OrderDialogState createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog> {
  TextEditingController _notesController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _tableNumberController = TextEditingController();
  Item? _selectedItem;
  List<Request> _requests = [];
  bool _isRequestEnabled = false;
  bool _isOrderEnabled = false;

  @override
  void dispose() {
    _notesController.dispose();
    _quantityController.dispose();
    _tableNumberController.dispose();
    super.dispose();
  }

  void _validateRequestFields(StateSetter setState) {
    setState(() {
      _isRequestEnabled = _selectedItem != null &&
          _notesController.text.isNotEmpty &&
          _quantityController.text.isNotEmpty;
    });
  }

  void _validateOrderFields(StateSetter setState) {
    setState(() {
      _isOrderEnabled = _requests.isNotEmpty &&
          _tableNumberController.text.isNotEmpty;
    });
  }

  void _addRequest() {
    String notes = _notesController.text;
    int quantity = int.tryParse(_quantityController.text) ?? 0;

    Request newRequest = Request(
      item: _selectedItem!,
      notes: notes,
      quantity: quantity,
    );

    widget.onAddRequest(newRequest);

    setState(() {
      _requests.add(newRequest);
      _clearRequestTextFields();
      _validateOrderFields(setState);
    });
  }

  void _clearRequestTextFields() {
    _notesController.clear();
    _quantityController.clear();
  }

  void _removeRequest(int index) {
    setState(() {
      _requests.removeAt(index);
      _validateOrderFields(setState);
    });
  }

  void _addOrder() {
    int tableNumber = int.tryParse(_tableNumberController.text) ?? 0;

    widget.onAddOrder(_requests, tableNumber);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Order'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: _requests.asMap().entries.map((entry) {
                int index = entry.key;
                Request request = entry.value;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text('${request.item.name} x${request.quantity}')),
                    Expanded(child: Text(request.notes)),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _removeRequest(index);
                      },
                    ),
                  ],
                );
              }).toList(),
            ),
            Divider(),
            StreamBuilder<List<Item>>(
              stream: ItemService.fetchItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No items found.'));
                }
                List<Item> items = snapshot.data!;
                return DropdownButton<Item>(
                  hint: Text('Select Item'),
                  value: _selectedItem,
                  onChanged: (Item? newValue) {
                    setState(() {
                      _selectedItem = newValue;
                    });
                    _validateRequestFields(setState);
                  },
                  items: items.map((Item item) {
                    return DropdownMenuItem<Item>(
                      value: item,
                      child: Text('${item.name} (${item.code}) - \$${item.price.toStringAsFixed(2)}'),
                    );
                  }).toList(),
                );
              },
            ),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(labelText: 'Notes'),
              onChanged: (value) {
                _validateRequestFields(setState);
              },
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _validateRequestFields(setState);
              },
            ),
            ElevatedButton(
              onPressed: _isRequestEnabled
                  ? () {
                _addRequest();
                setState(() {
                  _isRequestEnabled = false;
                });
              }
                  : null,
              child: Text('Add Request'),
            ),
            Divider(),
            TextField(
              controller: _tableNumberController,
              decoration: InputDecoration(labelText: 'Table Number'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _validateOrderFields(setState);
              },
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _isOrderEnabled
                  ? () {
                _addOrder();
                Navigator.of(context).pop();
              }
                  : null,
              child: Text('Submit Order'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}

