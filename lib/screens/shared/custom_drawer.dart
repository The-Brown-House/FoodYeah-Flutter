import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:foodyeah/screens/core/customers/customers_screen.dart';
import 'package:foodyeah/screens/core/orders/orders_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  final Color? color;
  CustomDrawer(this.color);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Map<String, dynamic>? data;
  bool isAdmin = false;

  Widget getListItem(name, icon, function, time) {
    return Column(
      children: [
        Divider(),
        ListTile(
          leading: Icon(icon),
          title: FadeAnimation(
              Text(name, style: GoogleFonts.varelaRound()), time, 1),
          onTap: function,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Customers>(context).getDataFromJwt().then((value) {
      data = value;
      if (data!['role'] == "USER") {
        setState(() {
          isAdmin = false;
        });
      } else {
        setState(() {
          isAdmin = true;
        });
      }
    });

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
              leading: Icon(Icons.home),
              title: FadeAnimation(
                  Text("Inicio", style: GoogleFonts.varelaRound()), 300, 1),
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/home', (route) => false);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.payment),
              title: FadeAnimation(
                  Text("Ordenes", style: GoogleFonts.varelaRound()), 600, 1),
              onTap: () {
                Navigator.of(context).pushNamed(OrdersScreen.routeName);
              },
            ),
            if (isAdmin)
              getListItem("Gestión de Productos", Icons.settings, () {}, 900),
            if (isAdmin)
              getListItem("Clientes", Icons.face, () {
                Navigator.of(context).pushNamed(CustomersScreen.routeName);
              }, 900),
            getListItem("Cerrar Sesión", Icons.logout, () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/", (route) => false);
            }, 900)
          ],
        ),
      ),
    );
  }
}
