import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/common/Messages.dart';
import 'package:foodyeah/models/Customer.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:foodyeah/screens/core/home.dart';
import 'package:foodyeah/services/notification_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class LoginForm extends StatefulWidget {
  const LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with TickerProviderStateMixin {



  Future<void> _loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.i.login(permissions: ['email','public_profile']);
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final userData = await FacebookAuth.i.getUserData();
        //para ver los datos del user en fb
        print(userData);
      }
    }
    catch (e, s) {
      print(s);
    }
  }

  CustomerLoginDto _toSend = new CustomerLoginDto("", "");
  final transitionType = ContainerTransitionType.fade;
  bool loader = false;

  final _emailFocusNode = FocusNode();
  final _contrasenaFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  void _saveForm(Function open) {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        loader = true;
      });

      Provider.of<Customers>(context, listen: false)
          .loginUser(_toSend, context)
          .then((value) {
        if (value == true) {
          open();
          NotificationService()
              .showSnackbar(context, Messages().successLogIn, "success", null);
          _formKey.currentState!.reset();
        }
        setState(() {
          loader = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
        Container(
          alignment: Alignment.topCenter,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _emailFocusNode,
                      onFieldSubmitted: (_) {
                        Focus.of(context).requestFocus(_contrasenaFocusNode);
                      },
                      onSaved: (value) {
                        _toSend = CustomerLoginDto(value!, _toSend.password);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Por favor ingrese su correo";
                        }
                        if (!value.contains("@")) {
                          return "Por favor ingrese un correo valido";
                        }
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Correo',
                          labelStyle: TextStyle(
                              fontFamily:
                                  GoogleFonts.varelaRound().fontFamily)),
                    ),
                    TextFormField(
                      focusNode: _contrasenaFocusNode,
                      textInputAction: TextInputAction.done,
                      onSaved: (value) {
                        _toSend = CustomerLoginDto(_toSend.email, value!);
                      },
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Por favor ingrese su contraseña";
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(
                              fontFamily:
                                  GoogleFonts.varelaRound().fontFamily)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    OpenContainer(
                      routeSettings: RouteSettings(name: Home.routeName),
                      transitionDuration: Duration(seconds: 1),
                      transitionType: transitionType,
                      closedElevation: 0,
                      openElevation: 0,
                      openBuilder: (context, _) => Home(),
                      closedBuilder: (_, open) => loader
                          ? Container(
                              padding: EdgeInsets.all(4),
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                              ),
                            )
                          : SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    _saveForm(open);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Theme.of(context).primaryColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                  child: Text(
                                    "Iniciar Sesión",
                                    style:
                                        GoogleFonts.varelaRound(fontSize: 18),
                                  )),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "o ingresa con ",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    OpenContainer(
                      routeSettings: RouteSettings(name: Home.routeName),
                      transitionDuration: Duration(seconds: 1),
                      transitionType: transitionType,
                      closedElevation: 0,
                      openElevation: 0,
                      openBuilder: (context, _) => Home(),
                      closedBuilder: (_, open) => loader
                          ? Container(
                        padding: EdgeInsets.all(4),
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.blue),
                        ),
                      )
                          : SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FloatingActionButton(
                              backgroundColor: Color(0xff3b5998),
                              child: Icon(
                                FontAwesomeIcons.facebookSquare,
                                color: Colors.white,
                              ),
                              onPressed: _loginWithFacebook,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        400,
        1);
  }
}
