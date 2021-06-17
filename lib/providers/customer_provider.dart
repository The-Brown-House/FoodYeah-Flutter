import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodyeah/common/Messages.dart';
import 'package:foodyeah/common/Constants.dart';
import 'package:foodyeah/models/Customer.dart';
import 'package:foodyeah/services/notification_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

//Este es un provider de Customers, aca se utiliza para generar todo lo de los customers y por ahora obtener solo el token
//pero tambien se puede logear y registrarse

class Customers with ChangeNotifier {
  final String apiurl = Constants().url + "identity";
  var headers = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

  Future<void> registerUser(CustomerRegisterDto customer, BuildContext context) async {
    var uri = Uri.parse(apiurl + "/register");
    var body = jsonEncode({
      'email': customer.email,
      'password': customer.password,
      'firstname': customer.firstname,
      'lastname': customer.lastname
    });
    //aca hago el request y guardo el response, uso async y await porque bueno, good practice pero supongo que no es
    //necesario al menos porque no hay funciones async o awaint en el back
    var response = await http.post(uri, body: body, headers: headers);
    if (response.statusCode == 200) {
      //Este es un servicio que cree para notificar a los usuarios en una cosita
      //donde pones el mensaje (de la clase mensajes) y el tipo success o error
      NotificationService()
          .showSnackbar(context, Messages().successRegister, "success", null);
    } else {
      NotificationService()
          .showSnackbar(context, Messages().errorFormRegister, "error", null);
    }
  }

  Future<bool> loginUser(
      CustomerLoginDto customer, BuildContext context) async {
    var uri = Uri.parse(apiurl + "/login");
    var body =
        jsonEncode({'email': customer.email, 'password': customer.password});
    var response = await http.post(uri, body: body, headers: headers);

    if (response.statusCode == 200) {
      //aca en caso de que cuando te logees el code sea 200, te da el mensaje de success y guarda el token
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.body);
      return true;
    } else {
      NotificationService()
          .showSnackbar(context, Messages().errorLogIn, "error", null);
      return false;
    }
  }

  Future<bool> isUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return token!.isEmpty;
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    return token;
  }

  Future<Map<String, dynamic>> getDataFromJwt() async {
    var token = await getToken();
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload;
  }

  Future<Customer> getCustomerByEmail(String email) async {
    var uri = Uri.parse(Constants().url + "customers/email/" + email);
    var response = await http.get(uri, headers: headers);
    return Customer.fromJson(jsonDecode(response.body));
  }

  Future<List<CustomerLOC>> getCustomersLOC() async {
    var uri = Uri.parse(Constants().url + "customers/onlycustomers");
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var itemsJson = body['items'] as List;
      var items = itemsJson.map((e) => CustomerLOC.fromJson(e)).toList();
      return items;
    }
    return [];
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
