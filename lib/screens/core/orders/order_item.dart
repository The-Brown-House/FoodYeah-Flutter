import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/models/Order.dart';
import 'package:foodyeah/models/OrderDetail.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderItem extends StatefulWidget {
  final Order order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 300,
      height: 200,
      child: FadeAnimation(
          Card(
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Orden número ",
                            style: GoogleFonts.varelaRound(fontSize: 20)),
                        Text("#" + widget.order.orderId.toString(),
                            style: GoogleFonts.varelaRound(
                                fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: Text("Detalles de la orden",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.varelaRound(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      width: double.infinity,
                      height: 90,
                      child: ListView.builder(
                          itemCount: widget.order.orderDetails!.length,
                          itemBuilder: (ctx, indx) {
                            List<OrderDetail>? orderDetails =
                                widget.order.orderDetails;
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              orderDetails![indx]
                                                  .productImageUrl!),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Text(
                                              orderDetails[indx].productName!),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(orderDetails[indx].quantity.toString() +
                                      " x S/" +
                                      orderDetails[indx].unitPrice.toString() +
                                      " = S/" +
                                      orderDetails[indx].totalPrice.toString())
                                ],
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text("Precio Total: ",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.varelaRound(fontSize: 12)),
                              Text(
                                "S/." + widget.order.totalPrice.toString(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.varelaRound(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Text(widget.order.status.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.varelaRound(
                                  fontSize: 12,
                                  color: widget.order.status == "NOTDELIVERED"
                                      ? Colors.red
                                      : Colors.green.shade900)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          600,
          1),
    );
  }
}
