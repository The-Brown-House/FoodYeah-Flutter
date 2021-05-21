import 'package:flutter/material.dart';

class CartItem {
  final String? ProductId;
  final int? quantity;
  final double? price;

  CartItem(
      {@required this.ProductId,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              ProductId: existingCartItem.ProductId,
              quantity: existingCartItem.quantity! + 1,
              price: price));
    } else {
      _items.putIfAbsent(productId,
          () => CartItem(ProductId: productId, quantity: 1, price: price));
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;

    _items.forEach((key, cartItem) {
      total += cartItem.price! * cartItem.quantity!;
    });

    return total;
  }

  void removeItem(id) {
    _items.remove(id);
    print(_items);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
