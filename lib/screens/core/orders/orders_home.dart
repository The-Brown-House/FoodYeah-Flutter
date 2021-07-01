import 'package:flutter/material.dart';
import 'package:foodyeah/models/Order.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:foodyeah/providers/orders_provider.dart';
import 'package:provider/provider.dart';

import 'order_item.dart';

class OrdersHome extends StatefulWidget {
  @override
  _OrdersHomeState createState() => _OrdersHomeState();
}

class _OrdersHomeState extends State<OrdersHome> {
  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<Orders>(context);
    var customerProvider = Provider.of<Customers>(context);

    Future<List<Order>>? getData() async {
      var tokenData = await customerProvider.getDataFromJwt();
      var items = await orderProvider.getOrderByEmail(tokenData['email']);
      return items;
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: getData(),
              builder: (ctx, snapshot) {
                if (snapshot.data != null) {
                  var items = snapshot.data as List<Order>;
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (ctx, index) => Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                        child: OrderItem(items[index]),
                      ),
                    ),
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
      ),
    );
  }
}
