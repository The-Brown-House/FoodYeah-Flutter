import 'package:foodyeah/models/Product_Category.dart';

class Product {
  final String? id;
  final String? name;
  final double? price;
  final String? imageUrl;
  final String? sellDay;
  final int? stock;
  final String? description;
  final ProductCategory? category;

  factory Product.fromJson(dynamic json) {
    Map<String, dynamic> productcat = json['product_Category'];
    ProductCategory productcategory = new ProductCategory(
        id: productcat['product_CategoryId'].toString(),
        name: productcat['product_CategoryName'],
        description: productcat['product_CategoryDescription']);
    return Product(
        id: json['productId'].toString(),
        description: json['productDescription'] as String,
        imageUrl: json['imageUrl'] as String,
        name: json['productName'] as String,
        price: json['productPrice'] as double,
        sellDay: json['sellDay'].toString(),
        stock: json['stock'] as int,
        category: productcategory);
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
