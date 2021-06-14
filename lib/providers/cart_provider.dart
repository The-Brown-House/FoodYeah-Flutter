import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:http/http.dart' as http;

class CartItem {
  final String? productId;
  final int? quantity;
  final double? price;

  CartItem(
      {@required this.productId,
      @required this.quantity,
      @required this.price});

  Map<String, dynamic> toJson() {
    return {
      'productId': this.productId,
      'quantity': this.quantity,
      'price': this.price
    };
  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  var headers = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

  Map<String, CartItem> get items {
    return {..._items};
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items'] = this.items;
    return data;
  }

  final reference = FirebaseDatabase.instance.reference();

  void addItem(String productId, double price) async {
    // var uri = Uri.parse(
    //   'https://testingfirebaseflutter-dc486-default-rtdb.firebaseio.com/cartPerCustomer.json');

    var tokenData = await Customers().getDataFromJwt();
    var customerData = await Customers().getCustomerByEmail(tokenData['email']);

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

      var cartList = _items.values.toList();
      // ignore: unused_local_variable
      var jsonCartList = cartList.map((e) => e.toJson()).toList();
      /*   var response = await http.post(uri,
          headers: headers,
          body: jsonEncode({
            'cartId': customerData.customerId,
            'customerEmail': customerData.email,
            'cart': jsonCartList
          }));*/
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
