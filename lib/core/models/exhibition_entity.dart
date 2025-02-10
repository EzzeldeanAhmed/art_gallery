import 'dart:io';

class ExhibitionEntity {
  final String name;
  final String overview;
  File? image;
  String? imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  List<dynamic> artworks = [];
  String? id;
  final String location;
  final String museumName;

  ExhibitionEntity(
      {required this.name,
      required this.overview,
      required this.startDate,
      required this.endDate,
      required this.location,
      this.image,
      this.imageUrl,
      this.id,
      required this.artworks,
      required this.museumName});
}
