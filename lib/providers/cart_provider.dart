import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addItem(CartItem cartItem) {
    _cartItems.add(cartItem);
    notifyListeners();
  }

  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  bool isProductInCart(String productId) {
    for (var cartItem in _cartItems) {
      if (cartItem.productId == productId) {
        return true;
      }
    }
    return false;
  }

  double get totalPrice {
    double totalPrice = 0;
    for (var cartItem in _cartItems) {
      totalPrice += cartItem.price * cartItem.quantity;
    }
    return totalPrice;
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

class CartItem {
  final String? id;
  final String productId;
  final String imageUrl;
  final String name;
  int quantity;
  final int price;

  CartItem({
    this.id,
    required this.imageUrl,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });
}
