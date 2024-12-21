import 'dart:io';

import 'package:art_gallery/core/models/review_entity.dart';

class ArtworkEntity {
  final String code;
  final String name;
  final String type;
  final String medium;
  final String country;
  final String description;
  final String epoch;
  final String artist;
  final String dimensions;
  final num year;
  File? image;
  String? imageUrl;
  String? id;
  final List<ReviewEntity> reviews;

  ArtworkEntity(
      {required this.code,
      required this.name,
      required this.type,
      required this.medium,
      required this.country,
      required this.description,
      required this.epoch,
      required this.artist,
      required this.reviews,
      required this.year,
      required this.dimensions,
      this.image,
      this.imageUrl,
      this.id});
}
