import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/widgets/custom_error_widget.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_favorites/favorites_grid_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artworks_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ArtworksGridViewFavBlocBuilder extends StatelessWidget {
  const ArtworksGridViewFavBlocBuilder({super.key});

  Future<List<ArtworkEntity>> getFavoriteArtworks() async {
    var authRepo = getIt.get<AuthRepo>();
    var saved_user = authRepo.getSavedUserData();
    var user = await authRepo.getUserData(uid: saved_user.uId);
    authRepo.saveUserData(user: user);
    var artworkRepo = getIt.get<ArtworksRepo>();
    List<ArtworkEntity> artworks = [];
    for (var artworkId in user.favoriteArtworks) {
      var result = await artworkRepo.getArtworkById(artworkId);
      var artwork = result.fold((l) => null, (r) => r);
      if (artwork != null) {
        artworks.add(artwork);
      }
    }
    return artworks;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFavoriteArtworks(),
        builder: (context, AsyncSnapshot<List<ArtworkEntity>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ArtworksGridViewFav(
              artworks: snapshot.data!,
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            return SliverToBoxAdapter(
                child: CustomErrorWidget(text: snapshot.error.toString()));
          } else {
            return Skeletonizer.sliver(
                enabled: true,
                child: const ArtworksGridViewFav(
                  artworks: [],
                ));
          }
        });
  }
}
