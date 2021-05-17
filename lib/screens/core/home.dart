import 'package:flutter/material.dart';
import 'package:foodyeah/providers/customer_provider.dart';
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

    return Scaffold(
        body: Center(
      child: Container(
        child: Text(provider.IsUser() != null
            ? "Hay un token guardado"
            : "No hay un token guardado y hay un error porque no puede estar aqui"),
      ),
    ));
  }
}
