import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:foodyeah/screens/core/products/product_detail.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListItem extends StatefulWidget {
  final Product? product;
  ProductListItem(this.product);

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget makeProduct({image, title, price}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetail.routeName, arguments: widget.product);
      },
      child: Hero(
        tag: Key(widget.product!.imageUrl.toString()),
        child: Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                    Colors.black.withOpacity(.7),
                    Colors.black.withOpacity(.1),
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FadeAnimation(
                              Text(title,
                                  style: GoogleFonts.varelaRound(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              600,
                              1),
                          FadeAnimation(
                              Text(
                                "S/" + price,
                                style: GoogleFonts.varelaRound(
                                    color: Colors.white, fontSize: 25),
                              ),
                              800,
                              1),
                        ],
                      ),
                      Column(children: [
                        FadeAnimation(
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: Center(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: Colors.transparent),
                                    onPressed: () {},
                                    child: Icon(Icons.shopping_cart)),
                              ),
                            ),
                            700,
                            1),
                      ])
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        height: 200,
        child: makeProduct(
            image: widget.product!.imageUrl,
            price: widget.product!.price.toString(),
            title: widget.product!.name));
  }
}
