import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/models/Customer.dart';
import 'package:foodyeah/providers/cart_provider.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:foodyeah/screens/core/cart/badge.dart';
import 'package:foodyeah/screens/core/cart/cart_screen.dart';
import 'package:foodyeah/screens/core/customer/customer_screen.dart';
import 'package:foodyeah/screens/core/customers/customers_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomersScreen extends StatefulWidget {
  CustomersScreen();

  static const routeName = "/customers";
  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  @override
  Widget build(BuildContext context) {
    var customerProvider = Provider.of<Customers>(context);
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 750),
                    pageBuilder: (_, __, ___) => CustomerScreen()),
              );
            },
            child: Hero(
              tag: Key("AvatarPhoto"),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20.0,
                child: Icon(
                  Icons.face,
                  color: Colors.black,
                ),
              ),
            ),
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
      backgroundColor: Colors.blueGrey.shade50,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FadeAnimation(
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Mis clientes",
                      style: GoogleFonts.varelaRound(fontSize: 25),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  600,
                  1),
              Container(
                child: FutureBuilder(
                  future: customerProvider.getCustomersLOC(),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        List<CustomerLOC> items =
                            snapshot.data as List<CustomerLOC>;

                        if (items.length > 0) {
                          return Container(
                            alignment: Alignment.topLeft,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (ctx, indx) =>
                                    CustomerList(items[indx])),
                          );
                        } else {
                          return Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.close,
                                    size: 50,
                                  ),
                                  Text("No tiene clientes",
                                      textAlign: TextAlign.center,
                                      style:
                                          GoogleFonts.varelaRound(fontSize: 25))
                                ]),
                          );
                        }
                      } else {
                        return Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Text("Load"),
                        );
                      }
                    } else {
                      return Container(
                        margin: EdgeInsets.only(top: 40),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
