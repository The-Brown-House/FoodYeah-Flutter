import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/providers/cart_provider.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:foodyeah/screens/core/menu/days_card.dart';
import 'package:foodyeah/screens/core/menu/menu_carta.dart';
import 'package:foodyeah/screens/core/orders/orders_screen.dart';
import 'package:foodyeah/screens/core/customer/customer_screen.dart';
import 'package:foodyeah/screens/shared/custom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:foodyeah/screens/core/cart/badge.dart';
import 'package:foodyeah/screens/core/cart/cart_screen.dart';

import 'orders/orders_home.dart';

class Home extends StatefulWidget {
  Home();
  //nombre de la ruta que se usa para el ruteo en main
  static const routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Aca estoy usando el provider de customers para obtener data
    //si pones listen: true cada vez que en el provider se realice el changenotifiers()
    //todo el widget recarga
    var customerProvider = Provider.of<Customers>(context, listen: true);
    var values = customerProvider.getDataFromJwt();
    var days = List.generate(5, (index) => index.toString());

    return Scaffold(
      drawer: CustomDrawer(Colors.redAccent),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.redAccent,
        elevation: 0,
        title: Image(
          image: AssetImage('assets/icon/icon.png'),
          width: 50,
          height: 50,
        ),
        actions: [
          TextButton(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Hero(
                  tag: 'AnimationSpeed',
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://media.discordapp.net/attachments/708078392376950807/839709195166941184/Picture3.jpg"),
                  ),
                )),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 750),
                    pageBuilder: (_, __, ___) => CustomerScreen()),
              );
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) =>
                Badge(child: ch, value: cart.itemCount.toString()),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FadeAnimation(
                FutureBuilder(
                  builder: (ctx, snapshot) {
                    if (snapshot.data != null) {
                      var data = snapshot.data as Map<String, dynamic>;
                      return Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Bienvenido, " + data['unique_name'],
                              style: GoogleFonts.varelaRound(fontSize: 25),
                            )),
                      );
                    } else {
                      return Container();
                    }
                  },
                  future: values,
                ),
                1000,
                1),
            FadeAnimation(
              Padding(
                padding: EdgeInsets.only(left: 15, top: 20, right: 15),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    filled: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.redAccent,
                      ),
                    ),
                    fillColor: Colors.white,
                    hintStyle: new TextStyle(color: Colors.grey, fontSize: 18),
                    hintText: "Busca un platillo",
                  ),
                ),
              ),
              1000,
              1,
            ),
            //Aca el tiempo de la animacion es mas larga porque demora en entrar al widget
            SizedBox(
              height: 20,
            ),
            FadeAnimation(
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Nuestro menú",
                        style: GoogleFonts.varelaRound(fontSize: 20)),
                  ),
                ),
                1200,
                1),
            FadeAnimation(
                Container(
                    width: 500,
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) => MenuDayCard(index),
                      itemCount: days.length,
                    )),
                1500,
                1),
            FadeAnimation(
                Padding(
                  padding: EdgeInsets.only(top: 25.0, left: 20.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Platillos a la carta",
                        style: GoogleFonts.varelaRound(fontSize: 20)),
                  ),
                ),
                1500,
                1),
            FadeAnimation(MenuCarta(), 1500, 1),
            FadeAnimation(
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Mis Pedidos",
                        style: GoogleFonts.varelaRound(fontSize: 20)),
                  ),
                ),
                1500,
                1),
            FadeAnimation(OrdersHome(), 1500, 1)
          ],
        ),
      ),
    );
  }
}
