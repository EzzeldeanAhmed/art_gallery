import 'dart:io';

import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/review_model.dart';

class ArtistModel {
  final String name;
  final String BirthDate;
  final String DeathDate;
  final String country;
  final String century;
  final String epoch;
  final String biography;
  final List<ReviewModel> reviews;
  File? image;
  String? imageUrl;
  final String? id;

  ArtistModel({
    required this.name,
    required this.BirthDate,
    required this.DeathDate,
    required this.country,
    required this.century,
    required this.epoch,
    required this.reviews,
    required this.biography,
    this.image,
    this.imageUrl,
    this.id,
  });

  factory ArtistModel.fromEntity(ArtistEntity addArtworkInputEntity) {
    return ArtistModel(
      name: addArtworkInputEntity.name,
      BirthDate: addArtworkInputEntity.BirthDate,
      DeathDate: addArtworkInputEntity.DeathDate,
      country: addArtworkInputEntity.country,
      century: addArtworkInputEntity.century,
      epoch: addArtworkInputEntity.epoch,
      biography: addArtworkInputEntity.biography,
      image: addArtworkInputEntity.image,
      imageUrl: addArtworkInputEntity.imageUrl,
      reviews: addArtworkInputEntity.reviews
          .map((e) => ReviewModel.fromEntity(e))
          .toList(),
    );
  }

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
        name: json['name'],
        BirthDate: json['BirthDate'],
        DeathDate: json['DeathDate'],
        country: json['country'],
        century: json['century'],
        epoch: json['epoch'],
        biography: json['biography'],
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
      'name': name,
      'BirthDate': BirthDate,
      'DeathDate': DeathDate,
      'country': country,
      'century': century,
      'epoch': epoch,
      'biography': biography,
      'imageUrl': imageUrl,
      'reviews': reviews.map((e) => e.toJson()).toList(),
    };
  }

  ArtistEntity toEntity() {
    return ArtistEntity(
        name: name,
        BirthDate: BirthDate,
        DeathDate: DeathDate,
        country: country,
        century: century,
        epoch: epoch,
        biography: biography,
        image: image,
        imageUrl: imageUrl,
        reviews: reviews.map((e) => e.toEntity()).toList(),
        id: id);
  }
}
