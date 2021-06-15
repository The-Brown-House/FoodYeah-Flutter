import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/providers/cart_provider.dart';
import 'package:foodyeah/screens/core/cart/badge.dart';
import 'package:foodyeah/screens/core/cart/cart_screen.dart';
import 'package:foodyeah/screens/core/customer/customer_screen.dart';
import 'package:foodyeah/screens/core/dashboard/product_categories/product_categories_dashboard.dart';
import 'package:foodyeah/screens/core/dashboard/products/products_dashboard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  static const routeName = "/dashboard";
  DashBoardScreen();

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            FadeAnimation(
                Text(
                  'Gestión de Tienda',
                  style: GoogleFonts.varelaRound(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                800,
                1),
            SizedBox(
              height: 10,
            ),
            FadeAnimation(
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 8,
                      shadowColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.of(context).pushNamed(ProductDashboard.routeName);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Productos",
                          style: GoogleFonts.varelaRound(color: Colors.black),
                        ),
                        Icon(
                          Icons.lunch_dining,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
                1000,
                1),
            SizedBox(
              height: 10,
            ),
            FadeAnimation(
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shadowColor: Colors.redAccent,
                    elevation: 8,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ProductCategoriesDashboard.routeName);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categoría de Productos",
                          style: GoogleFonts.varelaRound(color: Colors.black),
                        ),
                        Icon(
                          Icons.local_dining,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
                1200,
                1)
          ],
        ),
      ),
    );
  }
}
