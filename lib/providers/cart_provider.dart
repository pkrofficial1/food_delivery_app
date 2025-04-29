import 'package:flutter/material.dart';
import '/models/cart_item.dart';
import '/models/menu_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];
  String? _restaurantId;
  String? _restaurantName;

  List<CartItem> get items => _items;
  String? get restaurantId => _restaurantId;
  String? get restaurantName => _restaurantName;

  CartProvider() {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart');

    if (cartJson != null) {
      final cartMap = jsonDecode(cartJson) as Map<String, dynamic>;
      _restaurantId = cartMap['restaurantId'] as String?;
      _restaurantName = cartMap['restaurantName'] as String?;

      if (cartMap['items'] != null) {
        _items =
            (cartMap['items'] as List)
                .map((item) => CartItem.fromJson(item))
                .toList();
      }
    }

    notifyListeners();
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartMap = {
      'items': _items.map((item) => item.toJson()).toList(),
      'restaurantId': _restaurantId,
      'restaurantName': _restaurantName,
    };

    await prefs.setString('cart', jsonEncode(cartMap));
  }

  void addItem(MenuItem menuItem, int quantity) {
    // If cart is empty or from same restaurant, add item
    if (_restaurantId == null || _restaurantId == menuItem.restaurantId) {
      final existingItemIndex = _items.indexWhere(
        (item) => item.menuItem.id == menuItem.id,
      );

      if (existingItemIndex >= 0) {
        // Update quantity if item already exists
        final updatedItems = List<CartItem>.from(_items);
        updatedItems[existingItemIndex] = updatedItems[existingItemIndex]
            .copyWith(
              quantity: updatedItems[existingItemIndex].quantity + quantity,
            );

        _items = updatedItems;
        _restaurantId = menuItem.restaurantId;
      } else {
        // Add new item
        _items = [
          ..._items,
          CartItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            menuItem: menuItem,
            quantity: quantity,
          ),
        ];
        _restaurantId = menuItem.restaurantId;
      }

      notifyListeners();
      _saveCart();
    }
  }

  void removeItem(String itemId) {
    final updatedItems = _items.where((item) => item.id != itemId).toList();

    // If cart becomes empty, reset restaurant
    if (updatedItems.isEmpty) {
      _items = updatedItems;
      _restaurantId = null;
      _restaurantName = null;
    } else {
      _items = updatedItems;
    }

    notifyListeners();
    _saveCart();
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeItem(itemId);
      return;
    }

    final updatedItems =
        _items.map((item) {
          return item.id == itemId ? item.copyWith(quantity: quantity) : item;
        }).toList();

    _items = updatedItems;
    notifyListeners();
    _saveCart();
  }

  void clearCart() {
    _items = [];
    _restaurantId = null;
    _restaurantName = null;
    notifyListeners();
    _saveCart();
  }

  void setRestaurant(String id, String name) {
    _restaurantId = id;
    _restaurantName = name;
    notifyListeners();
    _saveCart();
  }

  double getTotalPrice() {
    return _items.fold(
      0,
      (total, item) => total + (item.menuItem.price * item.quantity),
    );
  }

  int getTotalItems() {
    return _items.fold(0, (total, item) => total + item.quantity);
  }
}
