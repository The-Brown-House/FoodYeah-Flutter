import 'package:flutter/material.dart';
import 'package:foodyeah/animation/FadeAnimation.dart';
import 'package:foodyeah/models/Customer.dart';
import 'package:foodyeah/providers/customer_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm();

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>
    with SingleTickerProviderStateMixin {
  CustomerRegisterDto _toSend = new CustomerRegisterDto("", "", "", "");

  AnimationController? controller;
  Animation<double>? animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller!);

    controller!.forward();
  }

  final _nombreFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _apellidoFocusNode = FocusNode();
  final _contrasenaFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool loader = false;

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      setState(() {
        loader = true;
      });
      _formKey.currentState!.save();
      Provider.of<Customers>(context, listen: false)
          .registerUser(_toSend, context)
          .then((value) {
        setState(() {
          loader = false;
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
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
                              fontFamily:
                                  GoogleFonts.varelaRound().fontFamily)),
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
                              fontFamily:
                                  GoogleFonts.varelaRound().fontFamily)),
                    ),
                    TextFormField(
                      focusNode: _emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_contrasenaFocusNode);
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
                              fontFamily:
                                  GoogleFonts.varelaRound().fontFamily)),
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
                              fontFamily:
                                  GoogleFonts.varelaRound().fontFamily)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    loader
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
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () => _saveForm(),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context).primaryColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
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
        ),
        400,
        1);
  }
}
