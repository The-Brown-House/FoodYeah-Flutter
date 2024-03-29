import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/common/Messages.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:foodyeah/providers/cart_provider.dart';
import 'package:foodyeah/screens/core/products/product_detail.dart';
import 'package:foodyeah/services/notification_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  Widget makeProduct({image, title, price, cartProvider}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetail.routeName, arguments: widget.product);
      },
      child: Hero(
        tag: Key(widget.product!.imageUrl.toString()),
        child: Container(
          height: double.infinity,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Colors.black.withOpacity(.7),
                  Colors.black.withOpacity(.1),
                ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(title,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.varelaRound(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                          ),
                          600,
                          1),
                      FadeAnimation(
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              "S/" + price,
                              style: GoogleFonts.varelaRound(
                                  color: Colors.white, fontSize: 25),
                            ),
                          ),
                          800,
                          1),
                    ],
                  ),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  FadeAnimation(
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0, primary: Colors.transparent),
                              onPressed: () {
                                cartProvider.addItem(widget.product!.id!,
                                    widget.product!.price!);
                                NotificationService().showSnackbar(
                                    context,
                                    Messages().successAddCart,
                                    "success",
                                    SnackBarAction(
                                        label: "Deshacer",
                                        onPressed: () {
                                          cartProvider
                                              .removeItem(widget.product!.id!);
                                        }));
                              },
                              child: Icon(Icons.shopping_cart)),
                        ),
                      ),
                      700,
                      1),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: 300,
        height: 200,
        child: makeProduct(
            image: widget.product!.imageUrl,
            price: widget.product!.price.toString(),
            title: widget.product!.name,
            cartProvider: cartProvider));
  }
}
