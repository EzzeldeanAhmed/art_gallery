import 'dart:io';

import 'package:art_gallery/core/models/cart_entity.dart';
import 'package:flutter/foundation.dart';

class CartModel {
  final String userID;
  final List<String> artworksID;
  String? id;

  CartModel({required this.userID, required this.artworksID, this.id});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      userID: json['userID'],
      artworksID: List<String>.from(json['artworksID']),
      id: json['id'],
    );
  }

  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(
      userID: entity.userID,
      artworksID: entity.artworksID,
      id: entity.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'artworksID': artworksID,
    };
  }

  CartEntity toEntity() {
    return CartEntity(
      userID: userID,
      artworksID: artworksID,
      id: id,
    );
  }
}
