import 'dart:io';

import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/collection_entity.dart';
import 'package:art_gallery/core/models/review_model.dart';

class CollectionModel {
  final String name;
  final String overview;
  String? id;
  CollectionModel({
    required this.name,
    required this.overview,
    this.id,
  });

  factory CollectionModel.fromEntity(CollectionEntity addArtworkInputEntity) {
    return CollectionModel(
      name: addArtworkInputEntity.name,
      overview: addArtworkInputEntity.overview,
      id: addArtworkInputEntity.id,
    );
  }

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
        name: json['name'], overview: json['overview'], id: json['id']);
  }

  toJson() {
    return {
      'name': name,
      'overview': overview,
    };
  }

  CollectionEntity toEntity() {
    return CollectionEntity(name: name, overview: overview, id: id);
  }
}
