import 'dart:io';
import 'dart:math';

import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/models/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  String? status = 'permanent';
  String? collectionID = 'main';
  DateTime? borrowDate;
  DateTime? returnDate;
  bool? forSale = true;
  int? price = 0;
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
      this.id,
      this.status,
      this.collectionID,
      this.borrowDate,
      this.returnDate,
      this.forSale,
      this.price});

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
      status: addArtworkInputEntity.status,
      collectionID: addArtworkInputEntity.collectionID,
      borrowDate: addArtworkInputEntity.borrowDate,
      returnDate: addArtworkInputEntity.returnDate,
      forSale: addArtworkInputEntity.forSale,
      price: addArtworkInputEntity.price,
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
        id: json['id'],
        status: json['status'],
        collectionID: json['collectionID'],
        borrowDate: json['borrowDate'] != null
            ? (json['borrowDate'] as Timestamp).toDate()
            : null,
        returnDate: json['returnDate'] != null
            ? (json['returnDate'] as Timestamp).toDate()
            : null,
        forSale: json['forSale'],
        price: json['price']);
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
      'status': status ?? 'permanent',
      'collectionID': collectionID ?? 'Main',
      'borrowDate': borrowDate,
      'returnDate': returnDate,
      // 'forSale': false,
      'forSale': forSale ?? true,
      // 'price': null
      'price': price,
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
        id: id,
        status: status,
        collectionID: collectionID,
        borrowDate: borrowDate,
        returnDate: returnDate,
        forSale: forSale,
        price: price);
  }
}
