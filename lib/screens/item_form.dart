// lib/screens/item_form.dart

import 'package:flutter/material.dart';
import '../services/item_service.dart';
import '../models/item_model.dart';

class ItemForm extends StatefulWidget {
  final Item? item;
  final bool isEditing;

  ItemForm({this.item, this.isEditing = false});

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  final ItemService _itemService = ItemService();
  late String name;
  late int quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Item' : 'Add Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.item?.name ?? '',
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              TextFormField(
                initialValue: widget.item?.quantity.toString() ?? '',
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  quantity = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.isEditing) {
                      _itemService
                          .update(widget.item!.id!, Item(name: name, quantity: quantity))
                          .then((_) => Navigator.pop(context));
                    } else {
                      _itemService
                          .create(Item(name: name, quantity: quantity))
                          .then((_) => Navigator.pop(context));
                    }
                  }
                },
                child: Text(widget.isEditing ? 'Update' : 'Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
