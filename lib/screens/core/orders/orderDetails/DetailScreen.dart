import 'package:flutter/material.dart';
import 'package:foodyeah/models/Order.dart';
import 'package:foodyeah/models/OrderDetail.dart';
import 'package:foodyeah/providers/cart_provider.dart';
import 'package:foodyeah/screens/core/cart/badge.dart';
import 'package:foodyeah/screens/core/cart/cart_screen.dart';
import 'package:foodyeah/screens/shared/custom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen();
  static const routeName = "/orderDetail";
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Order;

    return Scaffold(
      //drawer: CustomDrawer(Colors.blue),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
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
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey.shade50,
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          child: SizedBox(
            height: (MediaQuery.of(context).size.height),
            width: (MediaQuery.of(context).size.width),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                      "Detalles de la orden #" + args.orderId.toString(),
                      textAlign: TextAlign.left,
                      style: GoogleFonts.varelaRound(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(height: 10, width: double.infinity),
                Container(
                  height: (MediaQuery.of(context).size.height) * 0.7,
                  width: (MediaQuery.of(context).size.width),
                  child: ListView.builder(
                      itemCount: args.orderDetails!.length,
                      itemBuilder: (ctx, indx) {
                        List<OrderDetail>? orderDetails = args.orderDetails;
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image(
                                  image: NetworkImage(
                                      orderDetails![indx].productImageUrl!),
                                  height: 120,
                                  width: 150,
                                ),
                              ),
                              Container(width: 20),
                              Column(
                                children: [
                                  Text(orderDetails[indx].productName!,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.varelaRound(
                                          fontSize: 15, fontWeight: FontWeight.bold)),
                                  Text(
                                      "Cantidad: " +
                                          orderDetails[indx]
                                              .quantity
                                              .toString(),
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.varelaRound(
                                          fontSize: 15)),
                                  Text(
                                      "Precio Unidad: S/." +
                                          orderDetails[indx]
                                              .unitPrice
                                              .toString(),
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.varelaRound(
                                          fontSize: 15)),
                                  Text(
                                      "Total: S/." +
                                          orderDetails[indx]
                                              .totalPrice
                                              .toString(),
                                      textAlign: TextAlign.left,
                                      style:
                                          GoogleFonts.varelaRound(fontSize: 15))
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                ),
                const Divider(
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                Container(height: 10, width: double.infinity),
                Container(
                  width: double.infinity,
                  child: Text("ITEMS:" + args.orderDetails!.length.toString(),
                      textAlign: TextAlign.left,
                      style: GoogleFonts.varelaRound(fontSize: 20)),
                ),
                Container(height: 10, width: double.infinity),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text("Total: ",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.varelaRound(fontSize: 20)),
                          Text(
                            "S/." + args.totalPrice.toString(),
                            textAlign: TextAlign.left,
                            style: GoogleFonts.varelaRound(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Text(args.status.toString(),
                          style: GoogleFonts.varelaRound(
                              fontSize: 20,
                              color: args.status == "NOTDELIVERED"
                                  ? Colors.red
                                  : Colors.green.shade900)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
