import 'package:flutter/material.dart';

class CartItem {
  final String? productId;
  final int? quantity;
  final double? price;

  CartItem(
      {@required this.productId,
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
              productId: existingCartItem.productId,
              quantity: existingCartItem.quantity! + 1,
              price: price));
    } else {
      _items.putIfAbsent(productId,
          () => CartItem(productId: productId, quantity: 1, price: price));
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

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    } else {
      if (_items[productId]!.quantity! > 1) {
        _items.update(
            productId,
            (existingCartItem) => CartItem(
                productId: existingCartItem.productId,
                quantity: existingCartItem.quantity! - 1,
                price: existingCartItem.price));
      } else {
        _items.remove(productId);
      }
    }
    notifyListeners();
  }
}
