import 'dart:io';

import 'package:art_gallery/core/models/review_entity.dart';

class OrderItemEntity {
  final String artworkId;
  final double price;

  OrderItemEntity({required this.artworkId, required this.price});
}

class OrderEntity {
  final String orderId;
  final String orderDate;
  final String orderStatus;

  final String userId;
  final List<OrderItemEntity> orderItems;
  final String streetAddress;
  final String phone;
  final String fullName;
  final String city;

  OrderEntity(
      {required this.orderId,
      required this.orderDate,
      required this.orderStatus,
      required this.userId,
      required this.orderItems,
      required this.streetAddress,
      required this.phone,
      required this.fullName,
      required this.city});
}
