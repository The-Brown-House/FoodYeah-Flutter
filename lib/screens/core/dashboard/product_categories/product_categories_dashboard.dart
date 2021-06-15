import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/models/Product_Category.dart';
import 'package:foodyeah/providers/cart_provider.dart';
import 'package:foodyeah/providers/product_categories_provider.dart';
import 'package:foodyeah/screens/core/cart/badge.dart';
import 'package:foodyeah/screens/core/cart/cart_screen.dart';
import 'package:foodyeah/screens/core/customer/customer_screen.dart';
import 'package:foodyeah/screens/core/dashboard/product_categories/product_category_dashboard_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductCategoriesDashboard extends StatefulWidget {
  static const routeName = "/product-categories-dashboard";

  ProductCategoriesDashboard();

  @override
  _ProductCategoriesDashboardState createState() =>
      _ProductCategoriesDashboardState();
}

class _ProductCategoriesDashboardState
    extends State<ProductCategoriesDashboard> {
  @override
  Widget build(BuildContext context) {
    var productCategoryProvider = Provider.of<ProductCategories>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.redAccent,
        elevation: 0,
        title: Image(
          image: AssetImage('assets/icon/icon.png'),
          width: 50,
          height: 50,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 750),
                    pageBuilder: (_, __, ___) => CustomerScreen()),
              );
            },
            child: Hero(
              tag: Key("AvatarPhoto"),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20.0,
                child: Icon(
                  Icons.face,
                  color: Colors.black,
                ),
              ),
            ),
          ),
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
        automaticallyImplyLeading: true,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: FadeAnimation(
                      Text(
                        "Categorías",
                        style: GoogleFonts.varelaRound(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      1000,
                      1)),
              FutureBuilder(
                future: productCategoryProvider.getAllProductCategories(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var items = snapshot.data as List<ProductCategory>;
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          100,
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemBuilder: (ctx, indx) {
                              return ProductCategoryDashboardItem(items[indx]);
                            },
                            itemCount: items.length,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  primary: Colors.red,
                                  padding: EdgeInsets.all(10),
                                ),
                                child: Icon(Icons.add),
                                onPressed: () {},
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(top: 40),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          )),
    );
  }
}
