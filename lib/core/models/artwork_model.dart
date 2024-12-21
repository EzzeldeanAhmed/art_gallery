import 'dart:io';

import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/models/review_model.dart';

class ArtworkModel {
  final String code;
  final String name;
  final String type;
  final String medium;
  final String country;
  final String description;
  final String epoch;
  final String artist;
  final num year;
  final List<ReviewModel> reviews;
  final String dimensions;
  File? image;
  String? imageUrl;
  final String? id;

  ArtworkModel(
      {required this.code,
      required this.name,
      required this.type,
      required this.medium,
      required this.country,
      required this.description,
      required this.epoch,
      required this.reviews,
      required this.artist,
      required this.year,
      required this.dimensions,
      this.image,
      this.imageUrl,
      this.id});

  factory ArtworkModel.fromEntity(ArtworkEntity addArtworkInputEntity) {
    return ArtworkModel(
      code: addArtworkInputEntity.code,
      name: addArtworkInputEntity.name,
      type: addArtworkInputEntity.type,
      medium: addArtworkInputEntity.medium,
      country: addArtworkInputEntity.country,
      description: addArtworkInputEntity.description,
      epoch: addArtworkInputEntity.epoch,
      artist: addArtworkInputEntity.artist,
      year: addArtworkInputEntity.year,
      dimensions: addArtworkInputEntity.dimensions,
      image: addArtworkInputEntity.image,
      imageUrl: addArtworkInputEntity.imageUrl,
      reviews: addArtworkInputEntity.reviews
          .map((e) => ReviewModel.fromEntity(e))
          .toList(),
    );
  }

  factory ArtworkModel.fromJson(Map<String, dynamic> json) {
    return ArtworkModel(
        code: json['code'],
        name: json['name'],
        type: json['type'],
        medium: json['medium'],
        country: json['country'],
        description: json['description'],
        epoch: json['epoch'],
        artist: json['artist'],
        year: json['year'],
        dimensions: json['dimensions'],
        image: json['image'],
        imageUrl: json['imageUrl'],
        reviews: json['reviews'] != null
            ? List<ReviewModel>.from(
                json['reviews'].map((e) => ReviewModel.fromJson(e)))
            : [],
        id: json['id']);
  }

  toJson() {
    return {
      'code': code,
      'name': name,
      'type': type,
      'medium': medium,
      'country': country,
      'description': description,
      'epoch': epoch,
      'artist': artist,
      'year': year,
      'dimensions': dimensions,
      'imageUrl': imageUrl,
      'reviews': reviews.map((e) => e.toJson()).toList(),
    };
  }

  ArtworkEntity toEntity() {
    return ArtworkEntity(
        code: code,
        name: name,
        type: type,
        medium: medium,
        country: country,
        description: description,
        epoch: epoch,
        artist: artist,
        year: year,
        dimensions: dimensions,
        image: image,
        imageUrl: imageUrl,
        reviews: reviews.map((e) => e.toEntity()).toList(),
        id: id);
  }
}
