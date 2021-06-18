import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodyeah/common/Constants.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final String apiurl = Constants().url + "products";
  var headers = {
    "Accept": "application/json",
    "content-type": "application/json"
  };
  Future<List<Product>> getProductsBySellDay(int sellDay) async {
    var uri = Uri.parse(apiurl + "/day/" + sellDay.toString());
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var itemsJson = body['items'] as List;
      var items = itemsJson.map((e) => Product.fromJson(e)).toList();
      return items;
    }
    return [];
  }

  Future<Product?> getProductById(String id) async {
    var uri = Uri.parse(apiurl + "/" + id);
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var item = Product.fromJson(body);
      return item;
    }
    return new Product(
        id: "", imageUrl: "", name: "", price: 0, sellDay: "0", stock: 1);
  }

  Future<List<Product>> getProductByCategoryId(int id) async {
    var uri = Uri.parse(apiurl + "/category/" + id.toString());
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var itemsJson = body['items'] as List;
      var items = itemsJson.map((e) => Product.fromJson(e)).toList();
      return items;
    }
    return [];
  }

  Future getProductByName(String name) async {
    var uri = Uri.parse(apiurl + "/search/$name");
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var itemsJson = body['items'] as List;
      var items = itemsJson.map((e) => Product.fromJson(e)).toList();
      return items;
    }
  }

  Future<List<Product>> getAllProducts() async {
    var uri = Uri.parse(apiurl);
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var itemsJson = body['items'] as List;
      var items = itemsJson.map((e) => Product.fromJson(e)).toList();
      return items;
    }
    return [];
  }

  Future<bool> deleteProduct(String productId) async {
    var uri = Uri.parse(apiurl + "/" + productId);
    var response = await http.delete(uri);
    if (response.statusCode != 500) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addProduct(Product _toSend) async {
    var uri = Uri.parse(apiurl);
    int valor = int.parse(_toSend.sellDay!);

    var body = jsonEncode({
      "productName": _toSend.name,
      "productPrice": _toSend.price,
      "sellDay": (valor + 1).toString(),
      "stock": _toSend.stock,
      "imageUrl": _toSend.imageUrl,
      "productDescription": _toSend.description,
      "product_CategoryId": _toSend.category!.id
    });
    var response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode != 500) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editProduct(Product _toSend, String productId) async {
    var uri = Uri.parse(apiurl + "/" + productId);

    int valor = int.parse(_toSend.sellDay!);

    var body = jsonEncode({
      "productName": _toSend.name,
      "productPrice": _toSend.price,
      "sellDay": (valor + 1).toString(),
      "stock": _toSend.stock,
      "imageUrl": _toSend.imageUrl,
      "productDescription": _toSend.description,
      "product_CategoryId": _toSend.category!.id
    });
    var response = await http.put(uri, headers: headers, body: body);
    if (response.statusCode != 500) {
      return true;
    } else {
      return false;
    }
  }
}
