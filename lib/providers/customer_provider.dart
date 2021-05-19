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
    //aca hago el request y guardo el response, uso async y await porque bueno, good practice pero supongo que no es
    //necesario al menos porque no hay funciones async o awaint en el back
    var response = await http.post(uri, body: body, headers: headers);
    if (response.statusCode == 200) {
      //Este es un servicio que cree para notificar a los usuarios en una cosita
      //donde pones el mensaje (de la clase mensajes) y el tipo success o error
      NotificationService()
          .ShowSnackbar(context, Messages().successRegister, "success");
    } else {
      NotificationService()
          .ShowSnackbar(context, Messages().errorFormRegister, "error");
    }
  }

  Future<bool> LoginUser(
      CustomerLoginDto customer, BuildContext context) async {
    var uri = Uri.parse(URI + "/login");
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
          .ShowSnackbar(context, Messages().errorLogIn, "error");
      return false;
    }
  }

  Future<bool> IsUser() async {
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
    var test = await getToken();
    Map<String, dynamic> payload = Jwt.parseJwt(test);
    return payload;
  }
}
