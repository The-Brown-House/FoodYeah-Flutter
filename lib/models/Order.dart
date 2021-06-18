import 'package:foodyeah/models/Customer.dart';
import 'package:foodyeah/models/QuoteDetail.dart';

import 'OrderDetail.dart';

class Order {
  final String? orderId;
  final List<OrderDetail>? orderDetails;
  final String? customerId;
  final Customer? customer;
  final DateTime? date;
  final String? initTime;
  final String? endTime;
  final double? totalPrice;
  final String? status;

  Order(
      {this.orderId,
      this.orderDetails,
      this.customer,
      this.customerId,
      this.date,
      this.initTime,
      this.endTime,
      this.status,
      this.totalPrice});

  factory Order.fromJson(dynamic json) {
    var orderDetailJson = json["orderDetails"] as List;
    List<OrderDetail> orderDetails = orderDetailJson
        .map((orderDetaildata) => OrderDetail.fromJson(orderDetaildata))
        .toList();

    return Order(
      orderId: json['orderId'].toString(),
      customerId: json['customerId'].toString(),
      status: json['status'].toString(),
      totalPrice: json['totalPrice'],
      date: DateTime.parse(json['date']),
      initTime: json['initTime'],
      endTime: json['endTime'],
      orderDetails: orderDetails,
    );
  }
}

class CreateOrderDto {
  final int customerId;
  final List<OrderDetailCreateDto> orderDetails;
  final QuoteDetail quoteDetails;
  CreateOrderDto(this.customerId, this.orderDetails, this.quoteDetails);
}
