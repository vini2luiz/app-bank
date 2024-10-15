// lib/models/item_model.dart

class Item {
  String? id;
  String name;
  int quantity;

  Item({this.id, required this.name, required this.quantity});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }
}
