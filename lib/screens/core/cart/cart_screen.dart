import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:foodyeah/providers/cart_provider.dart';
import 'package:foodyeah/providers/products_provider.dart';
import 'package:foodyeah/screens/core/cart/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen();

  static const routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    var productProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito de compras"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Spacer(),
                    Consumer<Cart>(
                      builder: (_, cart, child) => Chip(
                        label: Text('\S/${cart.totalAmount}',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1!
                                  .color,
                            )),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Registre su orden",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Carrito de compras",
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return FutureBuilder(
                    future: productProvider.getProductById(
                        cartProvider.items.values.toList()[index].productId!),
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          var product = snapshot.data as Product;

                          return CartItems(
                              cartProvider.items.values
                                  .toList()[index]
                                  .productId!,
                              cartProvider.items.values.toList()[index].price!,
                              cartProvider.items.values
                                  .toList()[index]
                                  .quantity!,
                              product.name.toString(),
                              product.imageUrl.toString());
                        } else {
                          return Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Text("Load"),
                          );
                        }
                      } else {
                        return Center(
                          child: Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.only(top: 40),
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
                itemCount: cartProvider.itemCount,
              ),
            )
          ],
        ),
      ),
    );
  }
}
