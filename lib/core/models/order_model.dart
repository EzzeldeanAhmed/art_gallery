import 'dart:io';

import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/order_entity.dart';
import 'package:art_gallery/core/models/review_model.dart';

class OrderItemModel {
  final String artworkId;
  final double price;

  OrderItemModel({
    required this.artworkId,
    required this.price,
  });

  factory OrderItemModel.fromEntity(OrderItemEntity addArtworkInputEntity) {
    return OrderItemModel(
      artworkId: addArtworkInputEntity.artworkId,
      price: addArtworkInputEntity.price,
    );
  }

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      artworkId: json['artworkId'],
      price: json['price'],
    );
  }

  toJson() {
    return {
      'artworkId': artworkId,
      'price': price,
    };
  }

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      artworkId: artworkId,
      price: price,
    );
  }
}

class OrderModel {
  final String orderId;
  final String orderDate;
  final String orderStatus;

  final String userId;
  final List<OrderItemModel> orderItems;
  String? id;
  final String streetAddress;
  final String phone;
  final String fullName;
  final String city;
  OrderModel({
    required this.orderId,
    required this.orderDate,
    required this.orderStatus,
    required this.userId,
    required this.orderItems,
    this.id = null,
    required this.streetAddress,
    required this.phone,
    required this.fullName,
    required this.city,
  });

  factory OrderModel.fromEntity(OrderEntity addArtworkInputEntity) {
    return OrderModel(
      orderId: addArtworkInputEntity.orderId,
      orderDate: addArtworkInputEntity.orderDate,
      orderStatus: addArtworkInputEntity.orderStatus,
      userId: addArtworkInputEntity.userId,
      orderItems: addArtworkInputEntity.orderItems
          .map((e) => OrderItemModel.fromEntity(e))
          .toList(),
      streetAddress: addArtworkInputEntity.streetAddress,
      phone: addArtworkInputEntity.phone,
      fullName: addArtworkInputEntity.fullName,
      city: addArtworkInputEntity.city,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      orderDate: json['orderDate'],
      orderStatus: json['orderStatus'],
      userId: json['userId'],
      orderItems: (json['orderItems'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
      id: json['id'] ?? null,
      streetAddress: json['streetAddress'],
      phone: json['phone'],
      fullName: json['fullName'],
      city: json['city'],
    );
  }

  toJson() {
    return {
      'orderId': orderId,
      'orderDate': orderDate,
      'orderStatus': orderStatus,
      'userId': userId,
      'orderItems': orderItems.map((e) => e.toJson()).toList(),
      'streetAddress': streetAddress,
      'phone': phone,
      'fullName': fullName,
      'city': city,
    };
  }

  OrderEntity toEntity() {
    return OrderEntity(
      orderId: orderId,
      orderDate: orderDate,
      orderStatus: orderStatus,
      userId: userId,
      orderItems: orderItems.map((e) => e.toEntity()).toList(),
      streetAddress: streetAddress,
      phone: phone,
      fullName: fullName,
      city: city,
    );
  }
}
