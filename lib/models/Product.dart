class Product {
  final String? id;
  final String? name;
  final double? price;
  final String? imageUrl;
  final String? sellDay;
  final int? stock;
  // final Product_Category? category;

  factory Product.fromJson(dynamic json) {
    return Product(
        id: json['productId'].toString(),
        imageUrl: json['imageUrl'] as String,
        name: json['productName'] as String,
        price: json['productPrice'] as double,
        sellDay: json['sellDay'].toString(),
        stock: json['stock'] as int);
  }

  Product({
    this.id,
    this.name,
    this.price,
    this.imageUrl,
    this.sellDay,
    this.stock,
    // this.category
  });
}
