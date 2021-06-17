import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:foodyeah/providers/cart_provider.dart';
import 'package:foodyeah/providers/products_provider.dart';
import 'package:foodyeah/screens/core/admin/product_dialog.dart';
import 'package:foodyeah/screens/core/cart/badge.dart';
import 'package:foodyeah/screens/core/cart/cart_screen.dart';
import 'package:foodyeah/screens/core/customer/customer_screen.dart';
import 'package:foodyeah/screens/core/products/product_list_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);
  static const routeName = "/admin-dashboard";

  @override
  _AdminScreenState createState() => _AdminScreenState();

}

class _AdminScreenState extends State<AdminScreen> {

  ProductDialog dialog = ProductDialog();




  Widget build(BuildContext context) {

    var productProvider = Provider.of<Products>(context);


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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FadeAnimation(
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "DashBoard Admin",
                      style: GoogleFonts.varelaRound(fontSize: 25),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  600,
                  1),
              Container(
                child: FutureBuilder(
                  future: productProvider.getAllProducts(),
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
                                    ListTile(
                                      title: Text(
                                        items[indx].name.toString()
                                      ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: (){
                                            productProvider.deleteProduct(int.parse(items[indx].id.toString()));

                                          },
                                        )
                                    )),
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
                                  Text("No cuentas con platos registrados",
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (BuildContext context) => dialog.buildDialog(context));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
