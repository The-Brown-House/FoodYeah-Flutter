import 'package:flutter/material.dart';
import 'package:foodyeah/models/Customer.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm();

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  CustomerRegisterDto _toSend = new CustomerRegisterDto("", "", "", "");

  final _nombreFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _apellidoFocusNode = FocusNode();
  final _contrasenaFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      Provider.of<Customers>(context, listen: false)
          .RegisterUser(_toSend, context);
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
                  "Registro",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: GoogleFonts.varelaRound().fontFamily,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  focusNode: _nombreFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_apellidoFocusNode);
                  },
                  onSaved: (value) {
                    _toSend = CustomerRegisterDto(_toSend.email,
                        _toSend.password, value!, _toSend.lastname);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Por favor ingrese su nombre";
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Nombre',
                      labelStyle: TextStyle(
                          fontFamily: GoogleFonts.varelaRound().fontFamily)),
                ),
                TextFormField(
                  focusNode: _apellidoFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_emailFocusNode);
                  },
                  onSaved: (value) {
                    _toSend = CustomerRegisterDto(_toSend.email,
                        _toSend.password, _toSend.firstname, value!);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Por favor ingrese su apellido";
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.contact_mail),
                      labelText: 'Apellido',
                      labelStyle: TextStyle(
                          fontFamily: GoogleFonts.varelaRound().fontFamily)),
                ),
                TextFormField(
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_contrasenaFocusNode);
                  },
                  onSaved: (value) {
                    _toSend = CustomerRegisterDto(value!, _toSend.password,
                        _toSend.firstname, _toSend.lastname);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Por favor ingrese su correo";
                    }
                    if (!value.contains("@")) {
                      return "Por favor ingrese un correo valido";
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Correo',
                      labelStyle: TextStyle(
                          fontFamily: GoogleFonts.varelaRound().fontFamily)),
                ),
                TextFormField(
                  focusNode: _contrasenaFocusNode,
                  obscureText: true,
                  onSaved: (value) {
                    _toSend = CustomerRegisterDto(_toSend.email, value!,
                        _toSend.firstname, _toSend.lastname);
                  },
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
                        "Regístrate",
                        style: GoogleFonts.varelaRound(fontSize: 18),
                      )),
                )
              ],
            )),
      ),
    );
  }
}
