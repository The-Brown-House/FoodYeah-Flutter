import 'package:flutter/material.dart';
import 'package:foodyeah/models/Product.dart';
import 'package:foodyeah/models/Product_Category.dart';
import 'package:foodyeah/providers/products_provider.dart';
import 'package:provider/provider.dart';


class ProductDialog {

  final txtName = TextEditingController();
  final txtPrice = TextEditingController();
  final txtCat = TextEditingController();
  final txtSellDay = TextEditingController();
  final txtStock = TextEditingController();
  final txtImg = TextEditingController();
  final txtProduct = TextEditingController();


  Widget buildDialog(BuildContext context, Product product, bool nuevo){
    var productProvider = Provider.of<Products>(context);

    if(!nuevo){


    }


    return AlertDialog(
      title: Text('Agregar Plato'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: txtName,
              decoration: InputDecoration(hintText: 'Nombre'),
            ),
            TextField(
              controller: txtPrice,
              decoration: InputDecoration(hintText: 'Precio'),
            ),
            TextField(
              controller: txtCat,
              decoration: InputDecoration(hintText: 'Categoria'),
            ),
            TextField(
              controller: txtProduct,
              decoration: InputDecoration(hintText: 'Descripcion'),
            ),
            TextField(
              controller: txtImg,
              decoration: InputDecoration(hintText: 'IMG'),
            ),
            TextField(
              controller: txtSellDay,
              decoration: InputDecoration(hintText: 'Dia de venta'),
            ),
            TextField(
              controller: txtStock,
              decoration: InputDecoration(hintText: 'Stock Disponible'),
            ),
            ElevatedButton(onPressed: (){
              ProductRegister uno = ProductRegister(txtName.text,double.parse(txtPrice.text) ,txtImg.text,txtSellDay.text,int.parse(txtStock.text),txtProduct.text,int.parse(txtCat.text));


              productProvider.createProduct(uno);


              Navigator.pop(context);
            }, child: Text('Create'))
          ],
        ),
      ),
    );
  }

}