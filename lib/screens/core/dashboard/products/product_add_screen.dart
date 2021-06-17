import 'package:flutter/material.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductAddScreen extends StatefulWidget {
  static const routeName = "/add_product";
  ProductAddScreen();

  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameFocusNode = FocusNode();
  final _productDescriptionFocusNode = FocusNode();
  final _productSellDayFocusNode = FocusNode();
  final _productPriceFocusNode = FocusNode();
  final _productCategoryIdFocusNode = FocusNode();
  final _productStockFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    var _product = ModalRoute.of(context)!.settings.arguments! as Product;

    void _updateImageUrl() {
      if (!_imageUrlFocus.hasFocus) {
        setState(() {});
      }
    }

    @override
    void dispose() {
      _imageUrlFocus.removeListener(_updateImageUrl);
      _productNameFocusNode.dispose();
      _productDescriptionFocusNode.dispose();
      _productSellDayFocusNode.dispose();
      _productPriceFocusNode.dispose();
      _productCategoryIdFocusNode.dispose();
      _productStockFocusNode.dispose();
      _imageUrlController.dispose();
      _imageUrlFocus.dispose();
      super.dispose();
    }

    @override
    void initState() {
      _imageUrlFocus.addListener(_updateImageUrl);
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _product.id == null
                ? Text(
                    "Agrega un producto",
                    style: GoogleFonts.varelaRound(fontSize: 25),
                  )
                : Text(
                    "Edite un producto",
                    style: GoogleFonts.varelaRound(fontSize: 25),
                  ),
            Form(
                child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                key: _formKey,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        labelText: 'Nombre del producto',
                        labelStyle: GoogleFonts.varelaRound()),
                    textInputAction: TextInputAction.next,
                    initialValue:
                        _product.name != null ? _product.name.toString() : "",
                    keyboardType: TextInputType.text,
                    focusNode: _productNameFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por favor ingrese un nombre";
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus();
                    },
                    onSaved: (value) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        labelText: 'Descripción del producto',
                        labelStyle: GoogleFonts.varelaRound()),
                    textInputAction: TextInputAction.next,
                    initialValue: _product.description != null
                        ? _product.description.toString()
                        : "",
                    keyboardType: TextInputType.text,
                    focusNode: _productDescriptionFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por favor ingrese una descripción";
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus();
                    },
                    onSaved: (value) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        labelText: 'Precio del producto',
                        labelStyle: GoogleFonts.varelaRound()),
                    textInputAction: TextInputAction.next,
                    initialValue: _product.price != null
                        ? _product.price.toString()
                        : null,
                    keyboardType: TextInputType.number,
                    focusNode: _productPriceFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por favor ingrese un precio";
                      }
                      if (double.tryParse(value)! <= 0) {
                        return "El número debe ser mayor que 0";
                      }
                      if (double.tryParse(value) == null) {
                        return "Ingrese un número correcto";
                      }

                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus();
                    },
                    onSaved: (value) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        labelText: 'Stock inicial del producto',
                        labelStyle: GoogleFonts.varelaRound()),
                    textInputAction: TextInputAction.next,
                    initialValue: _product.stock != null
                        ? _product.stock.toString()
                        : null,
                    keyboardType: TextInputType.number,
                    focusNode: _productStockFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por favor ingrese un stock";
                      }
                      if (double.tryParse(value)! <= 0) {
                        return "El número debe ser mayor que 0";
                      }
                      if (double.tryParse(value) == null) {
                        return "Ingrese un número correcto";
                      }

                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus();
                    },
                    onSaved: (value) {},
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
