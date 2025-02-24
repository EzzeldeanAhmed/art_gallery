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
  String? status = 'permanent';
  String? collectionID = 'main';
  DateTime? borrowDate;
  DateTime? returnDate;
  bool? forSale = true;
  int? price = 0;

  final List<ReviewEntity> reviews;
  String? videoUrl;
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
      this.id,
      this.status,
      this.collectionID,
      this.borrowDate,
      this.returnDate,
      this.forSale,
      this.price,
      this.videoUrl});
}
