class ProductCategory {
  final String? id;
  final String? name;
  final String? description;

  ProductCategory({this.id, this.name, this.description});

  factory ProductCategory.fromJson(dynamic json) {
    Map<String, dynamic> productcategories = json;

    return ProductCategory(
        id: productcategories['product_CategoryId'].toString(),
        description: productcategories['product_CategoryDescription'],
        name: productcategories['product_CategoryName']);
  }
}
