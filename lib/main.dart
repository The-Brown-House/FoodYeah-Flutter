import 'package:flutter/material.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:foodyeah/providers/products_provider.dart';
import 'package:foodyeah/screens/authentication/authentication_screen.dart';
import 'package:foodyeah/screens/core/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Customers()),
      ],
      child: MaterialApp(
        title: 'FoodYeah',
        theme: ThemeData(
            primaryColor: Colors.redAccent,
            accentColor: Color.fromRGBO(255, 30, 77, 1)),
        home: AuthenticationScreen(), //pagina por defecto
        routes: {
          Home.routeName: (ctx) => Home(), //pagina principal
        },
      ),
    );
  }
}
