import 'package:flutter/material.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:foodyeah/models/Product_Category.dart';
import 'package:foodyeah/providers/product_categories_provider.dart';
import 'package:foodyeah/providers/products_provider.dart';
import 'package:foodyeah/screens/core/dashboard/product_categories/product_categories_dashboard.dart';
import 'package:foodyeah/screens/core/dashboard/products/products_dashboard.dart';
import 'package:foodyeah/services/notification_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductAddScreen extends StatefulWidget {
  static const routeName = "/add_product";
  ProductAddScreen();

  @override
  _ProductAddScreenState createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen>
    with SingleTickerProviderStateMixin {
  Product _toSend = new Product(
      id: "",
      description: "",
      imageUrl: "",
      name: "",
      price: 0,
      sellDay: "",
      stock: 0);

  final _nameFocusNode = FocusNode();
  final _descripcionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _stockFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _selldaySelected;
  var _categorySelected = new ProductCategory(name: "Escoja una categoría");
  var dias = [
    "Lunes",
    "Martes",
    "Miercoles",
    "Jueves",
    "Viernes",
  ];

  @override
  Widget build(BuildContext context) {
    Product? _product = ModalRoute.of(context)!.settings.arguments! as Product?;
    var productProvider = Provider.of<Products>(context);
    var categoryProvider = Provider.of<ProductCategories>(context);

    void guardarForm() {
      final isValid = _formKey.currentState!.validate();
      if (isValid) {
        _formKey.currentState!.save();

        if (_product!.id == null) {
          showDialog(
              context: context,
              builder: (builder) {
                return AlertDialog(
                    title: Text("¿Estas Seguro?"),
                    content:
                        Text("¿Estas seguro que deseas guardar este producto?"),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            var response =
                                await productProvider.addProduct(_toSend);
                            if (response == true) {
                              NotificationService().showSnackbar(
                                  context,
                                  "Ha agregado el producto correctamente",
                                  "success",
                                  null);
                            } else {
                              NotificationService().showSnackbar(
                                  context,
                                  "Ha ocurrido un error al agregar el producto",
                                  "error",
                                  null);
                            }
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacementNamed(
                                ProductDashboard.routeName);
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
                    content:
                        Text("¿Estas seguro que deseas guardar esta producto?"),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            var response = await productProvider.editProduct(
                                _toSend, _product.id!);

                            if (response == true) {
                              NotificationService().showSnackbar(
                                  context,
                                  "Ha editado el producto correctamente",
                                  "success",
                                  null);
                            } else {
                              NotificationService().showSnackbar(
                                  context,
                                  "Ha ocurrido un error al editar el producto",
                                  "error",
                                  null);
                            }
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            Navigator.of(context).pushReplacementNamed(
                                ProductDashboard.routeName);
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
                guardarForm();
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
            _product!.id == null
                ? Text(
                    "Agrega un producto",
                    style: GoogleFonts.varelaRound(fontSize: 25),
                  )
                : Text(
                    "Edite un producto",
                    style: GoogleFonts.varelaRound(fontSize: 25),
                  ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      focusNode: _nameFocusNode,
                      initialValue: _product.id == null ? "" : _product.name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          labelText: 'Nombre del producto',
                          labelStyle: GoogleFonts.varelaRound()),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Por favor ingrese un nombre";
                        }
                      },
                      onFieldSubmitted: (_) {},
                      onSaved: (value) {
                        _toSend = Product(
                            id: _toSend.id,
                            name: value,
                            description: _toSend.description,
                            category: _toSend.category,
                            imageUrl: _toSend.imageUrl,
                            price: _toSend.price,
                            sellDay: _toSend.sellDay,
                            stock: _toSend.stock);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      focusNode: _descripcionFocusNode,
                      initialValue:
                          _product.id == null ? "" : _product.description,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          labelText: 'Descripción del producto',
                          labelStyle: GoogleFonts.varelaRound()),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Por favor ingrese una descripción";
                        }
                      },
                      onFieldSubmitted: (_) {},
                      onSaved: (value) {
                        _toSend = Product(
                            id: _toSend.id,
                            name: _toSend.name,
                            description: value,
                            category: _toSend.category,
                            imageUrl: _toSend.imageUrl,
                            price: _toSend.price,
                            sellDay: _toSend.sellDay,
                            stock: _toSend.stock);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      focusNode: _imageUrlFocusNode,
                      initialValue:
                          _product.id == null ? "" : _product.imageUrl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          labelText: 'Imagen del producto',
                          labelStyle: GoogleFonts.varelaRound()),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Por favor ingrese una imagen";
                        }
                      },
                      onFieldSubmitted: (_) {},
                      onSaved: (value) {
                        _toSend = Product(
                            id: _toSend.id,
                            name: _toSend.name,
                            description: _toSend.description,
                            category: _toSend.category,
                            imageUrl: value,
                            price: _toSend.price,
                            sellDay: _toSend.sellDay,
                            stock: _toSend.stock);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      focusNode: _priceFocusNode,
                      initialValue:
                          _product.id == null ? "" : _product.price.toString(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          labelText: 'Precio del producto',
                          labelStyle: GoogleFonts.varelaRound()),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Por favor ingrese un precio";
                        }
                        if (double.tryParse(value)! <= 0) {
                          return "El número debe ser mayor que 0";
                        }
                      },
                      onFieldSubmitted: (_) {},
                      onSaved: (value) {
                        _toSend = Product(
                            id: _toSend.id,
                            name: _toSend.name,
                            description: _toSend.description,
                            category: _toSend.category,
                            imageUrl: _toSend.imageUrl,
                            price: double.parse(value!),
                            sellDay: _toSend.sellDay,
                            stock: _toSend.stock);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      focusNode: _stockFocusNode,
                      initialValue:
                          _product.id == null ? "" : _product.stock.toString(),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          labelText: 'Stock inicial del producto',
                          labelStyle: GoogleFonts.varelaRound()),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Por favor ingrese un stock";
                        }
                        if (double.tryParse(value)! <= 0) {
                          return "El número debe ser mayor que 0";
                        }
                      },
                      onSaved: (value) {
                        _toSend = Product(
                            id: _toSend.id,
                            name: _toSend.name,
                            description: _toSend.description,
                            category: _toSend.category,
                            imageUrl: _toSend.imageUrl,
                            price: _toSend.price,
                            sellDay: _toSend.sellDay,
                            stock: int.parse(value!));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            labelText: "Día de venta",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            labelStyle: GoogleFonts.varelaRound()),
                        onChanged: (e) {
                          setState(() {
                            _selldaySelected = e as String;
                          });
                        },
                        value: _product.id == null
                            ? _selldaySelected
                            : dias[int.parse(_product.sellDay.toString()) - 1],
                        onSaved: (value) {
                          _toSend = Product(
                              id: _toSend.id,
                              name: _toSend.name,
                              description: _toSend.description,
                              category: _toSend.category,
                              imageUrl: _toSend.imageUrl,
                              price: _toSend.price,
                              sellDay:
                                  dias.indexOf(_selldaySelected).toString(),
                              stock: _toSend.stock);
                        },
                        validator: (value) => value == null
                            ? 'Por favor escoja un dia de venta'
                            : null,
                        items: dias
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: new Text(e),
                                ))
                            .toList()),
                    SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                        future: categoryProvider.getAllProductCategories(),
                        builder: (ctx, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            var itemsToUse =
                                snapshot.data as List<ProductCategory>;
                            return DropdownButtonFormField<ProductCategory>(
                              decoration: InputDecoration(
                                  labelText: _categorySelected != null
                                      ? _categorySelected.name
                                      : _product.category!.name,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  labelStyle: GoogleFonts.varelaRound(
                                    color: Colors.black,
                                  )),
                              items: itemsToUse
                                  .map((e) => DropdownMenuItem<ProductCategory>(
                                        value: e,
                                        child: new Text(e.name!),
                                      ))
                                  .toList(),
                              onChanged: (e) {
                                setState(() {
                                  _categorySelected = e!;
                                });
                              },
                              onSaved: (value) {
                                _toSend = Product(
                                    id: _toSend.id,
                                    name: _toSend.name,
                                    description: _toSend.description,
                                    category: _categorySelected,
                                    imageUrl: _toSend.imageUrl,
                                    price: _toSend.price,
                                    sellDay: _toSend.sellDay,
                                    stock: _toSend.stock);
                              },
                            );
                          } else {
                            return Text(
                              "Cargando categorías",
                              style: GoogleFonts.varelaRound(),
                            );
                          }
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
