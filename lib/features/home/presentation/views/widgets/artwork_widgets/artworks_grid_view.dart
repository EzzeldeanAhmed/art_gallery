import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/repos/cart_repo/cart_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/widgets/artwork_item.dart';
import 'package:art_gallery/core/widgets/custom_error_widget.dart';
import 'package:art_gallery/features/auth/domain/entites/user_entity.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArtworksGridView extends StatelessWidget {
  const ArtworksGridView({super.key, required this.artworks});
  final List<ArtworkEntity> artworks;
  Future<bool> isFav(ArtworkEntity artwork) async {
    var authRepo = getIt.get<AuthRepo>();
    var saved_user = authRepo.getSavedUserData();
    var user = await authRepo.getUserData(uid: saved_user.uId);
    authRepo.saveUserData(user: user);
    return user.favoriteArtworks.contains(artwork.id);
  }

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
          return FutureBuilder(
              future: isFav(artworks[index]),
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ArtworkItem(
                    authRepo: getIt<AuthRepo>(),
                    artworkEntity: artworks[index],
                    isFavorite: snapshot.data!,
                    onFavorite: () {},
                    onAddToCart: () async {
                      var userId = getIt.get<AuthRepo>().getSavedUserData().uId;
                      CartRepo cartRepo = getIt.get<CartRepo>();
                      var msg = await cartRepo
                          .addArtworkToCart(
                              userId: userId, artworkId: artworks[index].id!)
                          .then(
                        (value) {
                          return value.fold(
                            (l) => l,
                            (r) => r,
                          );
                        },
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${artworks[index].name}  ${msg}"),
                        ),
                      );
                    },
                  );
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasError) {
                  return CustomErrorWidget(text: snapshot.error.toString());
                } else {
                  return CustomErrorWidget(text: "");
                }
              });
        });
  }
}
