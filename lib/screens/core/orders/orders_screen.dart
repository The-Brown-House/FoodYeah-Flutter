import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/models/Order.dart';
import 'package:foodyeah/providers/cart_provider.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:foodyeah/providers/orders_provider.dart';
import 'package:foodyeah/screens/core/cart/badge.dart';
import 'package:foodyeah/screens/core/cart/cart_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'order_item.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen();
  static const routeName = "/orders";
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<Orders>(context);
    var customerProvider = Provider.of<Customers>(context);

    Future<List<Order>>? getData() async {
      var tokenData = await customerProvider.getDataFromJwt();
      var items = await orderProvider.getOrderByEmail(tokenData['email']);
      return items;
    }

    return Scaffold(
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
          Padding(
              padding: EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://media.discordapp.net/attachments/708078392376950807/839709195166941184/Picture3.jpg"),
              )),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tus Ordenes",
                style: GoogleFonts.varelaRound(fontSize: 25),
                textAlign: TextAlign.left,
              ),
              FutureBuilder(
                  future: getData(),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        var items = snapshot.data as List<Order>;
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (ctx, indx) =>
                                  OrderItem(items[indx])),
                        );
                      } else {
                        return Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Text("Load"),
                        );
                      }
                    } else {
                      return Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(top: 40),
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        ),
                      );
                    }


                  })
            ],
          ),
        ),
      ),
    );
  }
}
