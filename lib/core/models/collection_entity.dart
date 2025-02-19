import 'dart:io';

import 'package:art_gallery/core/models/review_entity.dart';

class CollectionEntity {
  final String name;
  final String overview;
  String? id;
  CollectionEntity({required this.name, required this.overview, this.id});
}
