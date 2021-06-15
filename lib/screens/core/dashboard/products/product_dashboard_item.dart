import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDasboardItem extends StatefulWidget {
  final Product product;
  ProductDasboardItem({required this.product});

  @override
  _ProductDasboardItemState createState() => _ProductDasboardItemState();
}

class _ProductDasboardItemState extends State<ProductDasboardItem> {
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
        Container(
          margin: EdgeInsets.all(10),
          child: Card(
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Flexible(
                        flex: 3,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                widget.product.name!,
                                style: GoogleFonts.varelaRound(
                                    fontWeight: FontWeight.bold),
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(widget.product.imageUrl!),
                                radius: 25,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Categoría: ",
                                    style: GoogleFonts.varelaRound(),
                                  ),
                                  Text(
                                    widget.product.category!.name!,
                                    style: GoogleFonts.varelaRound(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Stock: ",
                                    style: GoogleFonts.varelaRound(),
                                  ),
                                  Text(widget.product.stock.toString(),
                                      style: GoogleFonts.varelaRound(
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  customBorder: CircleBorder(),
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  )),
                              InkWell(
                                customBorder: CircleBorder(),
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              )),
        ),
        1000,
        1);
  }
}
