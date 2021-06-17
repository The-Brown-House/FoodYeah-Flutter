import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodyeah/common/Constants.dart';
import 'package:foodyeah/models/Product_Category.dart';
import 'package:http/http.dart' as http;

class ProductCategories with ChangeNotifier {
  final String apiurl = Constants().url + "product_categories";
  var headers = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

  Future<List<ProductCategory>> getAllProductCategories() async {
    var uri = Uri.parse(apiurl + '/simple');
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var itemsJson = body['items'] as List;
      var items = itemsJson.map((e) => ProductCategory.fromJson(e)).toList();
      return items;
    }
    return [];
  }

  Future<bool> deleteCategory(String categoryId) async {
    var uri = Uri.parse(apiurl + "/" + categoryId);
    var response = await http.delete(uri);
    if (response.statusCode != 500) {
      return true;
    } else {
      return false;
    }
  }
}
