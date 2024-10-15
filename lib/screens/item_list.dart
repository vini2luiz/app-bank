// lib/screens/item_list.dart

import 'package:flutter/material.dart';
import '../services/item_service.dart';
import '../models/item_model.dart';
import 'item_form.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final ItemService _itemService = ItemService();
  late Future<List<Item>> _items;

  @override
  void initState() {
    super.initState();
    _items = _itemService.getAll();
  }

  void _refreshItems() {
    setState(() {
      _items = _itemService.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ItemForm()),
              ).then((_) => _refreshItems());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Item>>(
        future: _items,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('Quantity: ${item.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemForm(item: item, isEditing: true),
                            ),
                          ).then((_) => _refreshItems());
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _itemService.delete(item.id!).then((_) => _refreshItems());
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No items found'));
          }
        },
      ),
    );
  }
}
