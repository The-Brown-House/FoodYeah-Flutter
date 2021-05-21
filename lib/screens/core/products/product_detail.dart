import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:foodyeah/providers/products_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  static const routeName = "/product-detail";

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with TickerProviderStateMixin {
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
    final args = ModalRoute.of(context)!.settings.arguments as Product;

    //var productProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.name!,
          style: GoogleFonts.varelaRound(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.orange.shade300,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Hero(
              tag: Key(args.imageUrl.toString()),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Image.network(
                  args.imageUrl!,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              )),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.51,
              child: Padding(
                padding: EdgeInsets.all(30),
                child: FadeAnimation(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(args.name!,
                            style: GoogleFonts.varelaRound(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("S/" + args.price!.toString(),
                            style: GoogleFonts.varelaRound(fontSize: 20)),
                        SizedBox(
                          height: 10,
                        ),
                        Text(args.description!.toString(),
                            style: GoogleFonts.varelaRound(fontSize: 20)),
                        Expanded(
                            child: Container(
                          alignment: Alignment.bottomLeft,
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.orange.shade400),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ))),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Agregar a la orden",
                                      style: GoogleFonts.varelaRound(
                                          fontSize: 20, color: Colors.black)),
                                  ElevatedButton(
                                      onPressed: null,
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all<double>(
                                                  0),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.transparent)),
                                      child: Icon(Icons.shopping_cart,
                                          color: Colors.black))
                                ],
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                    400,
                    2),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
            ),
          ),
        ]),
      ),
    );
  }
}
