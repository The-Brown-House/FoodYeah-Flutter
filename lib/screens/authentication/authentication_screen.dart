import 'package:flutter/material.dart';
import 'package:foodyeah/screens/authentication/register/register_form.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login/login_form.dart';

class AuthenticationScreen extends StatefulWidget {
  AuthenticationScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AuthenticationScreen> {
  List<bool> _selected = [true, false];

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Scaffold(
        body: Container(
          width: deviceWidth,
          height: deviceHeight,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: deviceHeight * 0.40,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://www.laespanolaaceites.com/wp-content/uploads/2019/06/pizza-con-chorizo-jamon-y-queso-1080x671.jpg"))),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ),
                    ),
                    Image(
                      image: AssetImage('assets/icon/icon.png'),
                      width: 130,
                      height: 130,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 120),
                  height:
                      _selected[0] ? deviceHeight * 0.5 : deviceHeight * 0.6,
                  width: deviceWidth * 0.85,
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: ToggleButtons(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(18),
                                    fillColor: Theme.of(context).primaryColor,
                                    selectedColor: Colors.white,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "Iniciar Sesión",
                                            style: GoogleFonts.varelaRound(),
                                          )),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text("Registrarse",
                                            style: GoogleFonts.varelaRound()),
                                      )
                                    ],
                                    isSelected: _selected,
                                    onPressed: (index) {
                                      setState(() {
                                        _selected = List.generate(
                                            _selected.length, (index) => false);
                                        _selected[index] = true;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                            if (_selected[0]) LoginForm(),
                            if (_selected[1]) RegisterForm()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
