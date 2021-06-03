import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/screens/core/customers/customers_screen.dart';
import 'package:foodyeah/screens/core/orders/orders_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatefulWidget {
  final Color? color;
  CustomDrawer(this.color);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
      child: Drawer(
        child: Column(
          children: [
            AppBar(
                title: Text("Menu", style: GoogleFonts.varelaRound()),
                automaticallyImplyLeading: false,
                backgroundColor: widget.color),
            Divider(),
            ListTile(
              leading: Icon(Icons.shop),
              title: FadeAnimation(
                  Text("Home", style: GoogleFonts.varelaRound()), 300, 1),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/home');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.payment),
              title: FadeAnimation(
                  Text("Orders", style: GoogleFonts.varelaRound()), 600, 1),
              onTap: () {
                Navigator.of(context).pushNamed(OrdersScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: FadeAnimation(
                  Text("Product Management", style: GoogleFonts.varelaRound()),
                  900,
                  1),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.list),
              title: FadeAnimation(
                  Text("Customers", style: GoogleFonts.varelaRound()),
                  900,
                  1),
              onTap: () {
                Navigator.of(context).pushNamed(CustomersScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
