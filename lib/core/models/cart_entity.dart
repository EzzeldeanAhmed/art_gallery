import 'dart:io';

import 'package:art_gallery/core/models/review_entity.dart';

class CartEntity {
  final String userID;
  final List<String> artworksID;
  String? id;

  CartEntity({required this.userID, required this.artworksID, this.id});
}
