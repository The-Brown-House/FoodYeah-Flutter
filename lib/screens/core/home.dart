import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/providers/cart_provider.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:foodyeah/screens/core/menu/days_card.dart';
import 'package:foodyeah/screens/core/customer/customer_screen.dart';
import 'package:foodyeah/screens/shared/custom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'cart/badge.dart';
import 'cart/cart_screen.dart';

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
              onPressed: (){
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
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.blueGrey.shade50,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                FadeAnimation(
                    FutureBuilder(
                      builder: (ctx, snapshot) {
                        if (snapshot.data != null) {
                          var data = snapshot.data as Map<String, dynamic>;
                          return Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Bienvenido, " + data['unique_name'],
                                style: GoogleFonts.varelaRound(fontSize: 25),
                              ));
                        } else {
                          return Container();
                        }
                      },
                      future: values,
                    ),
                    1000,
                    1), //Aca el tiempo de la animacion es mas larga porque demora en entrar al widget
                SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Nuestro menu",
                          style: GoogleFonts.varelaRound(fontSize: 20)),
                    ),
                    1200,
                    1),
                FadeAnimation(
                    Container(
                        width: double.infinity,
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) => MenuDayCard(index),
                          itemCount: days.length,
                        )),
                    1500,
                    1),
              ],
            )));
  }
}
