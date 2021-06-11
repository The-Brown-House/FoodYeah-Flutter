import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/models/Customer.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen();
  static const routeName = "/customer";

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    var customerProvider = Provider.of<Customers>(context);
    Future<Customer>? getCustomerData() async {
      var tokenData = await customerProvider.getDataFromJwt();
      var items = await customerProvider.getCustomerByEmail(tokenData['email']);
      return items;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Mi perfil'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              child: Hero(
                tag: 'AnimationSpeed',
                child: CircleAvatar(
                  radius: 100.0,
                  backgroundImage: NetworkImage(
                      'https://media.discordapp.net/attachments/708078392376950807/839709195166941184/Picture3.jpg'),
                ),
              ),
            ),
            FutureBuilder(
                future: getCustomerData(),
                builder: (ctx, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      var items = snapshot.data as Customer;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FadeAnimation(
                              Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 20.0),
                                child: ListTile(
                                  leading: Icon(Icons.account_circle,
                                      color: Colors.redAccent),
                                  title: Text(
                                      items.firstname! + ' ' + items.lastname!,
                                      style: GoogleFonts.varelaRound(
                                          color: Colors.black, fontSize: 18)),
                                ),
                              ),
                              450,
                              1),
                          FadeAnimation(
                              Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 20.0),
                                child: ListTile(
                                  leading: Icon(Icons.alternate_email,
                                      color: Colors.redAccent),
                                  title: Text(items.email!,
                                      style: GoogleFonts.varelaRound(
                                          color: Colors.black, fontSize: 18)),
                                ),
                              ),
                              500,
                              1),
                        ],
                      );
                    } else
                      return Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Text("Load"),
                      );
                  } else
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
                }),
          ],
        ),
      ),
    );
  }
}
