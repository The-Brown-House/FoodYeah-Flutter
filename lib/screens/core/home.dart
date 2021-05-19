import 'package:flutter/material.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home();
  //nombre de la ruta que se usa para el ruteo en main
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    //Aca estoy usando el provider de customers para obtener data
    //si pones listen: true cada vez que en el provider se realice el changenotifiers()
    //todo el widget recarga
    var provider = Provider.of<Customers>(context, listen: true);
    var values = provider.getDataFromJwt();
    var days = List.generate(7, (index) => index.toString());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade50,
          elevation: 0,
          title: Image(
            image: AssetImage('assets/icon/icon.png'),
            width: 50,
            height: 50,
          ),
          actions: [
            Padding(
                padding: EdgeInsets.all(5),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://media.discordapp.net/attachments/708078392376950807/839709195166941184/Picture3.jpg"),
                ))
          ],
          automaticallyImplyLeading: false,
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.blueGrey.shade50,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                FutureBuilder(
                  builder: (ctx, snapshot) {
                    var data = snapshot.data as Map<String, dynamic>;
                    return Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Bienvenido, " + data['family_name'],
                          style: GoogleFonts.varelaRound(fontSize: 25),
                        ));
                  },
                  future: values,
                ),
                Container(
                    width: double.infinity,
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) => Container(
                        width: 100,
                        height: 80,
                        child: Card(
                          child: Text(index.toString()),
                        ),
                      ),
                      itemCount: days.length,
                    ))
              ],
            )));
  }
}
