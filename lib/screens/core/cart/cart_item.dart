import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodyeah/providers/cart_provider.dart';

import 'package:provider/provider.dart';

class CartItems extends StatelessWidget {
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String imageUrl;

  CartItems(
      this.productId, this.price, this.quantity, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(productId),
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.all(14),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<Cart>(context, listen: false).removeItem(productId);
        },
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Text("¿Estas Seguro?"),
                  content: Text("¿Quieres eliminar este item del carrito?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text("No")),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Text("Si"),
                    )
                  ],
                );
              });
        },
        child: Card(
          margin: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(imageUrl),
                              ),
                              Text(title.toString()),
                              // ignore: unnecessary_brace_in_string_interps
                              Text('\S/${price} x${quantity}')
                            ],
                          ),
                          Column(
                            children: [
                              Text('Precio Total'),
                              Text('\S/${price * quantity}')
                            ],
                          )
                        ],
                      ))),
            ],
          ),
        ));
  }
}
