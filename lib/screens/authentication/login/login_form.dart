import 'package:flutter/material.dart';
import 'package:foodyeah/models/Customer.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:foodyeah/screens/core/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  CustomerLoginDto _toSend = new CustomerLoginDto("", "");

  final _emailFocusNode = FocusNode();
  final _contrasenaFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      Provider.of<Customers>(context, listen: false)
          .LoginUser(_toSend, context, Home.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Text(
                  "Ingresa",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: GoogleFonts.varelaRound().fontFamily,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
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
                          fontFamily: GoogleFonts.varelaRound().fontFamily)),
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
                          fontFamily: GoogleFonts.varelaRound().fontFamily)),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => _saveForm(),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      child: Text(
                        "Iniciar Sesión",
                        style: GoogleFonts.varelaRound(fontSize: 18),
                      )),
                )
              ],
            )),
      ),
    );
  }
}
