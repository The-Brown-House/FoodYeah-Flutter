import 'package:flutter/material.dart';
import 'package:foodyeah/models/Product_Category.dart';
import 'package:foodyeah/providers/product_categories_provider.dart';
import 'package:foodyeah/screens/core/dashboard/product_categories/product_categories_dashboard.dart';
import 'package:foodyeah/services/notification_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductCategoryAddScreen extends StatefulWidget {
  static const routeName = "/add-category";
  ProductCategoryAddScreen();

  @override
  _ProductCategoryAddState createState() => _ProductCategoryAddState();
}

class _ProductCategoryAddState extends State<ProductCategoryAddScreen> {
  ProductCategory _toSend =
      new ProductCategory(id: "", description: "", name: "");

  final _nameFocusNode = FocusNode();
  final _descripcionFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ProductCategory? _productCategory =
        ModalRoute.of(context)!.settings.arguments! as ProductCategory?;

    var categoryProvider = Provider.of<ProductCategories>(context);

    void _saveForm() {
      final isValid = _formKey.currentState!.validate();
      if (isValid) {
        _formKey.currentState!.save();

        if (_productCategory!.id == null) {
          showDialog(
              context: context,
              builder: (builder) {
                return AlertDialog(
                    title: Text("¿Estas Seguro?"),
                    content: Text(
                        "¿Estas seguro que deseas guardar esta categoría?"),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            var response = await categoryProvider
                                .addProductCategory(_toSend);

                            if (response == true) {
                              NotificationService().showSnackbar(
                                  context,
                                  "Ha agregado la categoría correctamente",
                                  "success",
                                  null);
                            } else {
                              NotificationService().showSnackbar(
                                  context,
                                  "Ha ocurrido un error al agregar la categoría",
                                  "error",
                                  null);
                            }
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            Navigator.of(context).pushReplacementNamed(
                                ProductCategoriesDashboard.routeName);
                          },
                          child: Text("Si")),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("No"))
                    ]);
              });
        } else {
          showDialog(
              context: context,
              builder: (builder) {
                return AlertDialog(
                    title: Text("¿Estas Seguro?"),
                    content: Text(
                        "¿Estas seguro que deseas guardar esta categoría?"),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            var response =
                                await categoryProvider.editProductCategory(
                                    _toSend, _productCategory.id!);

                            if (response == true) {
                              NotificationService().showSnackbar(
                                  context,
                                  "Ha editado la categoría correctamente",
                                  "success",
                                  null);
                            } else {
                              NotificationService().showSnackbar(
                                  context,
                                  "Ha ocurrido un error al editar la categoría",
                                  "error",
                                  null);
                            }
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            Navigator.of(context).pushReplacementNamed(
                                ProductCategoriesDashboard.routeName);
                          },
                          child: Text("Si")),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("No"))
                    ]);
              });
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                _saveForm();
              },
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _productCategory!.id == null
                ? Text(
                    "Agrega una categoría",
                    style: GoogleFonts.varelaRound(fontSize: 25),
                  )
                : Text(
                    "Edite una categoría",
                    style: GoogleFonts.varelaRound(fontSize: 25),
                  ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    focusNode: _nameFocusNode,
                    initialValue: _productCategory.id == null
                        ? ""
                        : _productCategory.name,
                    onFieldSubmitted: (_) {
                      Focus.of(context).requestFocus(_descripcionFocusNode);
                    },
                    onSaved: (value) {
                      _toSend = ProductCategory(
                          id: _toSend.id,
                          name: value,
                          description: _toSend.description);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por favor ingrese el nombre";
                      }
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        labelText: 'Nombre de la categoría',
                        labelStyle: TextStyle(
                            fontFamily: GoogleFonts.varelaRound().fontFamily)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    focusNode: _descripcionFocusNode,
                    textInputAction: TextInputAction.done,
                    initialValue: _productCategory.id == null
                        ? ""
                        : _productCategory.description,
                    onSaved: (value) {
                      _toSend = ProductCategory(
                          id: _toSend.id,
                          name: _toSend.name,
                          description: value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por favor ingrese la descripción";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        labelText: 'Descripción de la categoría',
                        labelStyle: TextStyle(
                            fontFamily: GoogleFonts.varelaRound().fontFamily)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
