import 'package:flutter/material.dart';
import '../models/orders.dart';

class OrderDetailsDialog extends StatelessWidget {
  final Order order;
  final Function(String) onSave;

  OrderDetailsDialog({required this.order, required this.onSave});

  @override
  Widget build(BuildContext context) {
    String selectedStatus = order.status;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
          title: Text('Order Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Table ${order.tableNumber}'),
              SizedBox(height: 8.0),
              Text(
                'Status:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: selectedStatus,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStatus = newValue!;
                  });
                },
                items: <String>['Pending', 'In Progress', 'Completed'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              Text(
                'Items:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: order.requests.map((request) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Expanded(child: Text('${request.item.name} (${request.item.code}) x${request.quantity}')),
                        SizedBox(width: 16.0),
                        Text(request.notes),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                onSave(selectedStatus);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
