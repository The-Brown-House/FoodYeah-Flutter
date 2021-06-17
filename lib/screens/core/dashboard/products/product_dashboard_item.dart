import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/common/Messages.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:foodyeah/providers/products_provider.dart';
import 'package:foodyeah/screens/core/dashboard/products/products_dashboard.dart';
import 'package:foodyeah/services/notification_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDasboardItem extends StatefulWidget {
  final Product product;
  ProductDasboardItem({required this.product});

  @override
  _ProductDasboardItemState createState() => _ProductDasboardItemState();
}

class _ProductDasboardItemState extends State<ProductDasboardItem>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<Products>(context);

    @override
    void dispose() {
      super.dispose();
    }

    void _deleteItem(String productId) {
      showDialog(
          context: context,
          builder: (builder) {
            return AlertDialog(
                title: Text("¿Estas Seguro?"),
                content:
                    Text("¿Estas seguro que deseas eliminar este producto?"),
                actions: [
                  TextButton(
                      onPressed: () async {
                        var response =
                            await productProvider.deleteProduct(productId);
                        if (response == true) {
                          NotificationService().showSnackbar(
                              context,
                              "Ha eliminado el producto correctamente",
                              "success",
                              null);
                        } else {
                          NotificationService().showSnackbar(
                              context,
                              "Ha ocurrido un error al eliminar el producto",
                              "error",
                              null);
                        }
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushReplacementNamed(ProductDashboard.routeName);
                      },
                      child: Text("Si")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("No"))
                ]);
          });
    }

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
                                  onTap: () {
                                    _deleteItem(widget.product.id!);
                                  },
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
