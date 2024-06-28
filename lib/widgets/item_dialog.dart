import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/items.dart';

class ItemDialog extends StatefulWidget {
  final Function(Item) onAddItem;

  ItemDialog({required this.onAddItem});

  @override
  _ItemDialogState createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  bool _isDoneEnabled = false;
  final Uuid _uuid = Uuid();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _validateFields(StateSetter setState) {
    setState(() {
      _isDoneEnabled = _nameController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty &&
          _priceController.text.isNotEmpty &&
          _codeController.text.isNotEmpty;
    });
  }

  void _addItem() {
    String name = _nameController.text;
    String description = _descriptionController.text;
    double price = double.parse(_priceController.text);
    String code = _codeController.text;

    Item newItem = Item(
      id: _uuid.v4(),
      name: name,
      description: description,
      price: price,
      code: code,
    );

    widget.onAddItem(newItem);
    _clearTextFields();
  }

  void _clearTextFields() {
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _codeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
            onChanged: (value) {
              _validateFields(setState);
            },
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            onChanged: (value) {
              _validateFields(setState);
            },
          ),
          TextField(
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              _validateFields(setState);
            },
          ),
          TextField(
            controller: _codeController,
            decoration: InputDecoration(labelText: 'Code'),
            onChanged: (value) {
              _validateFields(setState);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: _isDoneEnabled
              ? () {
            _addItem();
            Navigator.of(context).pop();
          }
              : null,
          child: Text('Done'),
        ),
      ],
    );
  }
}

