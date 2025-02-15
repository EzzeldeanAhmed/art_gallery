import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'artist_entity.dart';

class ExhibitionModel {
  final String name;
  final String overview;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final List<dynamic> artworks;
  final String location;
  final String? id;
  final String museumName;
  final double ticketPrice;
  final int capacity;

  ExhibitionModel(
      {required this.name,
      required this.overview,
      required this.startDate,
      required this.endDate,
      required this.location,
      required this.imageUrl,
      required this.artworks,
      this.id,
      required this.museumName,
      required this.ticketPrice,
      required this.capacity});

  factory ExhibitionModel.fromEntity(ExhibitionEntity exhibitionEntity) {
    return ExhibitionModel(
        name: exhibitionEntity.name,
        overview: exhibitionEntity.overview,
        startDate: exhibitionEntity.startDate,
        endDate: exhibitionEntity.endDate,
        location: exhibitionEntity.location,
        imageUrl: exhibitionEntity.imageUrl!,
        artworks: exhibitionEntity.artworks,
        museumName: exhibitionEntity.museumName,
        ticketPrice: exhibitionEntity.ticketPrice,
        capacity: exhibitionEntity.capacity);
  }

  factory ExhibitionModel.fromJson(Map<String, dynamic> e) {
    return ExhibitionModel(
        name: e['name'],
        overview: e['overview'],
        // timestamp to DateTime
        startDate: (e['startDate'] as Timestamp).toDate(),
        endDate: (e['endDate'] as Timestamp).toDate(),
        location: e['location'],
        imageUrl: e['imageUrl'],
        artworks: e['artworks'],
        id: e['id'],
        museumName: e['museumName'],
        ticketPrice: e['ticketPrice'] / 1.0,
        capacity: e['capacity']);
  }

  ExhibitionEntity toEntity() {
    return ExhibitionEntity(
        name: name,
        overview: overview,
        startDate: startDate,
        endDate: endDate,
        location: location,
        imageUrl: imageUrl,
        artworks: artworks,
        id: id,
        museumName: museumName,
        ticketPrice: ticketPrice,
        capacity: capacity);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'overview': overview,
      'startDate': startDate,
      'endDate': endDate,
      'location': location,
      'imageUrl': imageUrl,
      'artworks': artworks,
      'museumName': museumName,
      'ticketPrice': ticketPrice,
      'capacity': capacity
    };
  }
}
