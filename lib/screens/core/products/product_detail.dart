import 'package:flutter/material.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:foodyeah/providers/products_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  static const routeName = "/product-detail";

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Product;

    var productProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.name!,
          style: GoogleFonts.varelaRound(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.blueGrey.shade50,
        elevation: 0,
      ),
      body: Hero(
          tag: Key(args.imageUrl.toString()),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.network(
              args.imageUrl!,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
