import 'package:flutter/material.dart';
import 'package:foodyeah/screens/core/menu/menu_semanal.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuDayCard extends StatelessWidget {
  final int dayNumber;
  MenuDayCard(this.dayNumber);

  var days = ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes"];

  bool tap = false;

  Widget dayIcon() {
    if (dayNumber % 2 == 0) {
      return Icon(
        Icons.fastfood,
        color: Colors.redAccent,
      );
    } else {
      return Icon(Icons.restaurant_menu, color: Colors.redAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(MenuSemanal.routeName,
            arguments: {'id': dayNumber, 'dayName': days[dayNumber]});
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        child: SizedBox(
          width: 100,
          height: 80,
          child: Card(
            elevation: 8,
            shadowColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dayIcon(),
                Text(days[dayNumber],
                    style: GoogleFonts.varelaRound(
                        fontSize: 15, color: Colors.redAccent))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
