import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/widgets/artist_item.dart';
import 'package:art_gallery/core/widgets/artwork_item.dart';
import 'package:art_gallery/core/widgets/custom_error_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ArtistsGridView extends StatelessWidget {
  const ArtistsGridView({super.key, required this.artists});
  final List<ArtistEntity> artists;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        itemCount: artists.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 8,
          childAspectRatio: 4 / 2,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          // return CustomErrorWidget(text: "Error");
          return ArtistItem(
            artistEntity: artists[index],
          );
        });
  }
}
