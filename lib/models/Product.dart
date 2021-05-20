import 'package:foodyeah/models/Product_Category.dart';

class Product {
  final String? id;
  final String? name;
  final double? price;
  final String? imageUrl;
  final String? sellDay;
  final int? stock;
  final String? description;
  final Product_Category? category;

  factory Product.fromJson(dynamic json) {
    Map<String, dynamic> product_cat = json['product_Category'];
    Product_Category product_category = new Product_Category(
        product_cat['product_CategoryId'].toString(),
        product_cat['product_CategoryName'],
        product_cat['product_CategoryDescription']);
    return Product(
        id: json['productId'].toString(),
        description: json['productDescription'] as String,
        imageUrl: json['imageUrl'] as String,
        name: json['productName'] as String,
        price: json['productPrice'] as double,
        sellDay: json['sellDay'].toString(),
        stock: json['stock'] as int,
        category: product_category);
  }

  Product(
      {this.id,
      this.name,
      this.price,
      this.imageUrl,
      this.sellDay,
      this.stock,
      this.description,
      this.category});
}
