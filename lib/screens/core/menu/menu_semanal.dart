import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuSemanal extends StatefulWidget {
  MenuSemanal();
  static const routeName = "/weekly-menu";

  @override
  _MenuSemanalState createState() => _MenuSemanalState();
}

class _MenuSemanalState extends State<MenuSemanal> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.blueGrey.shade50,
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey.shade50,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            FadeAnimation(
                Text("Menu del día ${args['dayName']}",
                    style: GoogleFonts.varelaRound(fontSize: 25)),
                600)
          ],
        ),
      ),
    );
  }
}
