import 'package:flutter/material.dart';
import 'package:foodyeah/models/OrderDetail.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailItem extends StatefulWidget {
  final OrderDetail orderDetail;
  OrderDetailItem(this.orderDetail);

  @override
  _OrderDetailItemState createState() => _OrderDetailItemState();
}

class _OrderDetailItemState extends State<OrderDetailItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            elevation: 20,
            borderRadius: BorderRadius.circular(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                widget.orderDetail.productImageUrl!,
                height: 100.0,
                width: 150.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(width: 20),
          Column(
            children: [
              Text(widget.orderDetail.productName!,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.varelaRound(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              Text("Cantidad: " + widget.orderDetail.quantity.toString(),
                  textAlign: TextAlign.left,
                  style: GoogleFonts.varelaRound(fontSize: 15)),
              Text(
                  "Precio Unidad: S/." +
                      widget.orderDetail.unitPrice.toString(),
                  textAlign: TextAlign.left,
                  style: GoogleFonts.varelaRound(fontSize: 15)),
              Text("Total: S/." + widget.orderDetail.totalPrice.toString(),
                  textAlign: TextAlign.left,
                  style: GoogleFonts.varelaRound(fontSize: 15))
            ],
          )
        ],
      ),
    );
  }
}
