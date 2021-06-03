import 'package:flutter/material.dart';
import 'package:foodyeah/models/Customer.dart';

class CustomerList extends StatefulWidget {
  final CustomerLOC? customer;
  CustomerList(this.customer);

  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 80,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
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
                Text(
                    widget.customer!.firstname.toString() +
                        '\t' +
                        widget.customer!.lastname.toString(),
                    style: TextStyle(color: Colors.blue, fontSize: 20)),
                Text(widget.customer!.email.toString() + '\t'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Linea de credito restante: '),
                    Text(widget.customer!.loc.toString(),
                        style: TextStyle(color: Colors.redAccent, fontSize: 18)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
