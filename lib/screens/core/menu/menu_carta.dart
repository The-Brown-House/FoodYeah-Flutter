import 'package:flutter/material.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:foodyeah/providers/products_provider.dart';
import 'package:foodyeah/screens/core/products/product_detail.dart';
import 'package:foodyeah/screens/core/products/product_list_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuCarta extends StatefulWidget {
  @override
  _MenuCartaState createState() => _MenuCartaState();
}

class _MenuCartaState extends State<MenuCarta> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FutureBuilder(
            future: Provider.of<Products>(context).getProductByCategoryId(2),
            builder: (ctx, snapshot) {
              if (snapshot.data != null) {
                var items = snapshot.data as List<Product>;
                return Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (ctx, index) => Container(
                            margin: EdgeInsets.all(10),
                            child: ProductListItem(items[index]),
                          )),
                );
              } else {
                return Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.blue),
                    ));
              }
            },
          )
        ],
      ),
    );
  }
}

class CartaFoodTitles extends StatelessWidget {
  final Product product;

  CartaFoodTitles(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetail.routeName, arguments: product);
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            child: Card(
                color: Colors.white,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: 170,
                  height: 210,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            product.imageUrl!,
                            fit: BoxFit.scaleDown,
                          )),
                      Text(product.name!,
                          style: GoogleFonts.varelaRound(
                              color: Color(0xFF6e6e71),
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                      Text('\S/ ' + product.price!.toString(),
                          style: GoogleFonts.varelaRound(
                              color: Color(0xFF6e6e71),
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
