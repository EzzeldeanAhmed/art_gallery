import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/models/collection_entity.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/widgets/artwork_item.dart';
import 'package:art_gallery/core/widgets/custom_error_widget.dart';
import 'package:art_gallery/features/auth/domain/entites/user_entity.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/widgets/artwork_item_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArtworksGridViewCollection extends StatelessWidget {
  const ArtworksGridViewCollection(
      {super.key, required this.artworks, required this.collection});
  final List<dynamic> artworks;
  final dynamic collection;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('${collection.name}\'s Artworks '),
            pinned: true,
            snap: false,
            floating: false,
            backgroundColor: Colors.white,
            actions: [],
          ),
          SliverGrid.builder(
              itemCount: artworks.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 8,
                childAspectRatio: 2.2,
                crossAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                // return CustomErrorWidget(text: "Error");
                return ArtworkItemCollection(
                    authRepo: getIt<AuthRepo>(),
                    artworkEntity: artworks[index],
                    onFavorite: () {});
              })
        ],
      ),
    );
  }
}
