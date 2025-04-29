import '/models/menu_item.dart';

class CartItem {
  final String id;
  final MenuItem menuItem;
  final int quantity;
  final String? specialInstructions;

  CartItem({
    required this.id,
    required this.menuItem,
    required this.quantity,
    this.specialInstructions,
  });

  CartItem copyWith({
    String? id,
    MenuItem? menuItem,
    int? quantity,
    String? specialInstructions,
  }) {
    return CartItem(
      id: id ?? this.id,
      menuItem: menuItem ?? this.menuItem,
      quantity: quantity ?? this.quantity,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'menuItem': menuItem.toJson(),
      'quantity': quantity,
      'specialInstructions': specialInstructions,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      menuItem: MenuItem.fromJson(json['menuItem']),
      quantity: json['quantity'],
      specialInstructions: json['specialInstructions'],
    );
  }
}
