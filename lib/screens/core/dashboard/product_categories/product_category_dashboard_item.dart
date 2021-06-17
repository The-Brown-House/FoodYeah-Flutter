import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/models/Product_Category.dart';
import 'package:foodyeah/providers/product_categories_provider.dart';
import 'package:foodyeah/screens/core/dashboard/product_categories/product_categories_dashboard.dart';
import 'package:foodyeah/services/notification_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductCategoryDashboardItem extends StatefulWidget {
  final ProductCategory category;
  ProductCategoryDashboardItem(this.category);

  @override
  _ProductCategoryDashboardItemState createState() =>
      _ProductCategoryDashboardItemState();
}

class _ProductCategoryDashboardItemState
    extends State<ProductCategoryDashboardItem> {
  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<ProductCategories>(context);
    void _deleteItem(String categoryId) {
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
                            await categoryProvider.deleteCategory(categoryId);
                        if (response == true) {
                          NotificationService().showSnackbar(
                              context,
                              "Ha eliminado la categoría correctamente",
                              "success",
                              null);
                        } else {
                          NotificationService().showSnackbar(
                              context,
                              "Ha ocurrido un error al eliminar la categoría",
                              "error",
                              null);
                        }
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed(
                            ProductCategoriesDashboard.routeName);
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
                          height: 100,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                widget.category.name!,
                                style: GoogleFonts.varelaRound(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.category.description!,
                                style: GoogleFonts.varelaRound(
                                    fontWeight: FontWeight.bold),
                              ),
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
                                    _deleteItem(widget.category.id!);
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
