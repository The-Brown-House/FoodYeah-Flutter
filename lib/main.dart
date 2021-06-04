import 'package:flutter/material.dart';
import 'package:foodyeah/providers/cart_provider.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:foodyeah/providers/orders_provider.dart';
import 'package:foodyeah/providers/products_provider.dart';
import 'package:foodyeah/screens/authentication/authentication_screen.dart';
import 'package:foodyeah/screens/core/home.dart';
import 'package:foodyeah/screens/core/menu/menu_semanal.dart';
import 'package:foodyeah/screens/core/orders/orders_screen.dart';
import 'package:foodyeah/screens/core/products/product_detail.dart';
import 'package:provider/provider.dart';

import 'screens/core/cart/cart_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //El manejo de estados es para inutilizar los stateful widgets, son como los services en frontend
        // y aca (ya que se usa muchos providers) se pone todos los provinders es como que la rama principal y este se expande
        // a cada widget
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Customers()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders())
      ],
      child: MaterialApp(
        title: 'FoodYeah',
        theme: ThemeData(
            primaryColor: Colors.redAccent,
            accentColor: Colors.blueGrey.shade50),
        home: AuthenticationScreen(), //pagina por defecto
        routes: {
          //aca para routear se pone el nombre de la ruta y qué va a renderizar
          //nombre : funcion de flutter => Qué renderiza
          Home.routeName: (ctx) => Home(), //pagina principal
          MenuSemanal.routeName: (ctx) => MenuSemanal(),
          ProductDetail.routeName: (ctx) => ProductDetail(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen()
        },
      ),
    );
  }
}
