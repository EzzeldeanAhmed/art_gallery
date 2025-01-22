import 'dart:io';

import 'package:art_gallery/core/models/review_entity.dart';

class ArtistEntity {
  final String name;
  final String BirthDate;
  final String DeathDate;
  final String country;
  final String century;
  final String epoch;
  final String biography;
  File? image;
  String? imageUrl;
  String? id;
  final List<ReviewEntity> reviews;

  ArtistEntity(
      {required this.name,
      required this.BirthDate,
      required this.DeathDate,
      required this.country,
      required this.century,
      required this.biography,
      required this.epoch,
      required this.reviews,
      this.image,
      this.imageUrl,
      this.id});
}
