import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodyeah/common/Messages.dart';
import 'package:foodyeah/common/Constants.dart';
import 'package:foodyeah/models/Customer.dart';
import 'package:foodyeah/services/notification_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Customers with ChangeNotifier {
  final String URI = Constants().URL + "identity";
  var headers = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

  Future<void> RegisterUser(
      CustomerRegisterDto customer, BuildContext context) async {
    var uri = Uri.parse(URI + "/register");
    var body = jsonEncode({
      'email': customer.email,
      'password': customer.password,
      'firstname': customer.firstname,
      'lastname': customer.lastname
    });
    var response = await http.post(uri, body: body, headers: headers);
    if (response.statusCode == 200) {
      NotificationService()
          .ShowSnackbar(context, Messages().successRegister, "success");
    } else {
      NotificationService()
          .ShowSnackbar(context, Messages().errorFormRegister, "error");
    }
  }

  Future<void> LoginUser(
      CustomerLoginDto customer, BuildContext context, ruta) async {
    var uri = Uri.parse(URI + "/login");
    var body =
        jsonEncode({'email': customer.email, 'password': customer.password});
    var response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode == 200) {
      NotificationService()
          .ShowSnackbar(context, Messages().successLogIn, "success");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.body);
      Navigator.of(context).pushReplacementNamed(ruta);
    } else {
      NotificationService()
          .ShowSnackbar(context, Messages().errorLogIn, "error");
    }
  }

  Future<bool> IsUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return token!.isEmpty;
  }
}
