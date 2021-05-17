import 'package:flutter/material.dart';
import 'package:foodyeah/models/Product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Papa a la Huancaina',
      description: 'Deliciosa papa a la Huancaina que te alegrará el dia',
      price: 10.30,
      imageUrl:
          'https://www.perudelights.com/wp-content/uploads/2013/07/DSC022601.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Arroz con Pollo',
      description: 'Este es uno de los platos favoritos en las mesas peruanas,',
      price: 5.99,
      imageUrl:
          'https://images-gmi-pmc.edge-generalmills.com/8b79836e-e3b4-4099-bf3b-79a21257b759.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Arroz Chaufa',
      description: 'El mestizaje entre la comida criolla peruana y la china.',
      price: 6.59,
      imageUrl:
          'https://www.recetasderechupete.com/wp-content/uploads/2016/03/arroz_chaufa-768x527.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Locro de Zapallo',
      description:
          'El zapallo, además de delicioso, es un alimento saludable, nutritivo y muy versátil.',
      price: 9.99,
      imageUrl:
          'https://www.diariamenteali.com/medias/receta-locro-zapallo-1900Wx500H?context=bWFzdGVyfGltYWdlc3wyMzE1OTh8aW1hZ2UvanBlZ3xoZjAvaDcyLzkwNzM5ODA1NzE2NzgvcmVjZXRhLWxvY3JvLXphcGFsbG9fMTkwMFd4NTAwSHw5ODA5MDFhZDdjYmM5NTk3OGIyNDVmYTExZDg1ZjZhODAwZjE1OGY2NTZlYzk2NDg2MWFkOTI2NTdhYjE1MWRm',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite == true).toList();
  }

  void addProducts(Product product) {
    final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        id: DateTime.now().toString());
    _items.add(newProduct);
    notifyListeners();
  }

  void editProduct(Product product) {
    var index = _items.indexWhere((element) => product.id == element.id);
    this.deleteProduct(_items[index].id);
    _items.insert(index, product);
    notifyListeners();
  }

  void deleteProduct(productId) {
    _items.removeWhere((element) => element.id == productId);
    notifyListeners();
  }

  Product findById(id) {
    return _items.firstWhere((product) => product.id == id);
  }
}
