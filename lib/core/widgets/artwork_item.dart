import 'dart:ffi';

import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_network_image.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artwork_details_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ArtworkItem extends StatefulWidget {
  ArtworkItem({
    super.key,
    required this.artworkEntity,
    required this.authRepo,
    required this.isFavorite,
    required this.onFavorite,
  });
  final AuthRepo authRepo;

  final ArtworkEntity artworkEntity;
  Function onFavorite = () {};
  bool isFavorite;
  @override
  State<ArtworkItem> createState() => _ArtworkItemState(isFavorite: isFavorite);
}

class _ArtworkItemState extends State<ArtworkItem> {
  _ArtworkItemState({required this.isFavorite});
  bool isFavorite;
  @override
  Widget build(BuildContext context) {
    String modifiedName = widget.artworkEntity.name;
    int maxSize = 35;
    if (modifiedName.length > maxSize) {
      modifiedName = modifiedName.substring(0, maxSize) + "...";
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  ArtworkDetailsPage(artworkEntity: widget.artworkEntity)),
        );
      },
      child: Container(
        decoration: ShapeDecoration(
          color: const Color(0xFFF3F5F7),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                onPressed: () async {
                  var old_fav = isFavorite;
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  var saved_user = widget.authRepo.getSavedUserData();
                  var user =
                      await widget.authRepo.getUserData(uid: saved_user.uId);
                  if (!old_fav) {
                    widget.authRepo.addFavoriteArtwork(
                        uid: user.uId, artworkId: widget.artworkEntity.id!);
                  } else {
                    widget.authRepo.removeFavoriteArtwork(
                        uid: user.uId, artworkId: widget.artworkEntity.id!);
                  }
                  widget.authRepo.saveUserData(
                      user: await widget.authRepo.getUserData(uid: user.uId));
                  widget.onFavorite();
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color: isFavorite ? AppColors.red : Colors.black,
                ),
              ),
            ),
            Positioned.fill(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  widget.artworkEntity.imageUrl != null
                      ? Flexible(
                          child: CustomNetworkImage(
                              imageUrl: widget.artworkEntity.imageUrl!),
                        )
                      : Container(
                          color: Colors.grey,
                          height: 100,
                          width: 100,
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    title: Text(
                      modifiedName,
                      textAlign: TextAlign.left,
                      style: TextStyles.bold16,
                      // semibold16,
                    ),
                    subtitle: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            style: TextStyles.bold13.copyWith(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          TextSpan(
                            text: widget.artworkEntity.artist,
                            style: TextStyles.bold13.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: ' - ',
                            style: TextStyles.semiBold13.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: widget.artworkEntity.year.toString(),
                            style: TextStyles.bold13.copyWith(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    // trailing: const CircleAvatar(
                    //   backgroundColor: AppColors.primaryColor,
                    //   child: Icon(
                    //     Icons.add,
                    //     color: Colors.white,
                    //   ),
                    /*trailing: GestureDetector(
                    onTap: () {
                      context.read<CartCubit>().addProduct(artworkEntity);
                    },
                    child: const CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),*/
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
