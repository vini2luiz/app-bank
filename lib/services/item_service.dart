// lib/services/item_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';
import '../services/api_service.dart';

class ItemService extends ApiService<Item> {
  ItemService() : super('http://localhost:3000/items');

  @override
  Future<List<Item>> getAll() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  @override
  Future<Item> getById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Item.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load item');
    }
  }

  @override
  Future<Item> create(Item item) async {
    final response = await http.post(Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(item.toJson()));
    if (response.statusCode == 201) {
      return Item.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create item');
    }
  }

  @override
  Future<Item> update(String id, Item item) async {
    final response = await http.put(Uri.parse('$baseUrl/$id'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(item.toJson()));
    if (response.statusCode == 200) {
      return Item.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update item');
    }
  }

  @override
  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }
}
