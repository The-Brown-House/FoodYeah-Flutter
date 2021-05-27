import 'package:foodyeah/models/Order.dart';

import 'Product.dart';

class OrderDetailCreateDto {
  final String? productId;
  final double? quantity;

  OrderDetailCreateDto({this.productId, this.quantity});
}

class OrderDetail {
  final String? productId;
  final String? productName;
  final String? productImageUrl;
  final int? quantity;
  final double? unitPrice;
  final double? totalPrice;

  factory OrderDetail.fromJson(dynamic json) {
    return OrderDetail(
        productId: json['productId'].toString(),
        quantity: json['quantity'],
        totalPrice: json['totalPrice'],
        productImageUrl: json['product']['imageUrl'],
        productName: json['product']['productName'],
        unitPrice: json['unitPrice']);
  }

  OrderDetail(
      {this.productId,
      this.productImageUrl,
      this.productName,
      this.quantity,
      this.unitPrice,
      this.totalPrice});
}
