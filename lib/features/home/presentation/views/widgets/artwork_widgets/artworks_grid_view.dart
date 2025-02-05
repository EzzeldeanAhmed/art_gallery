import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/widgets/artwork_item.dart';
import 'package:art_gallery/core/widgets/custom_error_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ArtworksGridView extends StatelessWidget {
  const ArtworksGridView({super.key, required this.artworks});
  final List<ArtworkEntity> artworks;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        itemCount: artworks.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          childAspectRatio: 163 / 214,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          // return CustomErrorWidget(text: "Error");
          return ArtworkItem(
            artworkEntity: artworks[index],
          );
        });
  }
}
