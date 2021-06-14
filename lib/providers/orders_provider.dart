import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:foodyeah/common/Constants.dart';
import 'package:foodyeah/common/Messages.dart';
import 'package:foodyeah/models/Order.dart';
import 'package:foodyeah/services/notification_service.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  final String apiurl = Constants().url + "orders";
  var headers = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

  Future<List<Order>> getOrderByEmail(String email) async {
    var uri = Uri.parse(apiurl + "/email/" + email);
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var itemsJson = body['items'] as List;
      var items = itemsJson.map((e) => Order.fromJson(e)).toList();
      return items;
    }
    return [];
  }

  Future<bool> createOrder(CreateOrderDto order, context) async {
    var uri = Uri.parse(apiurl);

    List orderDetails =
        order.orderDetails.map((order) => order.toJson()).toList();

    var body = jsonEncode({
      'customerId': order.customerId,
      'orderDetails': orderDetails,
      'quoteDetails': order.quoteDetails.toJson()
    });
    var response = await http.post(uri, body: body, headers: headers);
    if (response.statusCode == 200) {
      NotificationService().showSnackbar(
          context, Messages().successOrderConfirmed, "success", null);
      return true;
    } else {
      NotificationService()
          .showSnackbar(context, Messages().errorOrderReject, "error", null);
      return false;
    }
  }
}
