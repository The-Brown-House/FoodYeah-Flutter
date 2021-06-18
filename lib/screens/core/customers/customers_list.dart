import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/models/Customer.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerList extends StatefulWidget {
  final CustomerLOC? customer;
  CustomerList(this.customer);

  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    Color getColorGroup() {
      var availibleloc = widget.customer!.availibleloc!;
      var fiftypercent = widget.customer!.totalloc! * 0.5;
      var thirtypercent = widget.customer!.totalloc! * 0.3;
      if (availibleloc < thirtypercent) {
        return Colors.red;
      }
      if (availibleloc > fiftypercent) {
        return Colors.green;
      }
      return Colors.yellow.shade800;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 80,
      child: SizedBox(
        width: double.infinity,
        height: 80,
        child: Card(
          elevation: 5,
          shadowColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeAnimation(
                  Text(
                      widget.customer!.firstname.toString() +
                          '\t' +
                          widget.customer!.lastname.toString(),
                      style: GoogleFonts.varelaRound(
                          color: Colors.blue.shade900, fontSize: 18)),
                  600,
                  1),
              FadeAnimation(
                  Text(widget.customer!.email.toString() + '\t',
                      style: GoogleFonts.varelaRound()),
                  800,
                  1),
              FadeAnimation(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Linea de credito restante: '),
                      Text(widget.customer!.availibleloc.toString(),
                          style: GoogleFonts.varelaRound(
                              fontSize: 15, color: getColorGroup())),
                    ],
                  ),
                  1000,
                  1)
            ],
          ),
        ),
      ),
    );
  }
}
