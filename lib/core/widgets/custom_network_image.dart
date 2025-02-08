import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.height = 220,
    this.width = 200,
  });

  final String imageUrl;
  double width = 200;
  double height = 220;

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl,
        height: height, width: width, fit: BoxFit.fitHeight);
  }
}
