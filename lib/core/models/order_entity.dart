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

  OrderEntity(
      {required this.orderId,
      required this.orderDate,
      required this.orderStatus,
      required this.userId,
      required this.orderItems});
}
