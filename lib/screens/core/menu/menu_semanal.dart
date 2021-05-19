import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:foodyeah/providers/products_provider.dart';
import 'package:foodyeah/screens/core/products/product_list_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuSemanal extends StatefulWidget {
  MenuSemanal();
  static const routeName = "/weekly-menu";

  @override
  _MenuSemanalState createState() => _MenuSemanalState();
}

class _MenuSemanalState extends State<MenuSemanal> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var productProvider = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.blueGrey.shade50,
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey.shade50,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FadeAnimation(
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Menu del día ${args['dayName']}",
                      style: GoogleFonts.varelaRound(fontSize: 25),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  600),
              Container(
                child: FutureBuilder(
                  future: productProvider.getProductsBySellDay(args['id']),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        List<Product> items = snapshot.data as List<Product>;

                        if (items.length > 0) {
                          return Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (ctx, indx) =>
                                    ProductListItem(items[indx])),
                          );
                        } else {
                          return Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.no_food,
                                    size: 50,
                                  ),
                                  Text("No hay platos designados para este día",
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
                              new AlwaysStoppedAnimation<Color>(Colors.blue),
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
