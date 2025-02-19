import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_network_image.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artwork_details_page.dart';
import 'package:flutter/material.dart';

class ArtworkItemCollection extends StatefulWidget {
  ArtworkItemCollection({
    super.key,
    required this.artworkEntity,
    required this.authRepo,
    required this.onFavorite,
  });

  final AuthRepo authRepo;
  final ArtworkEntity artworkEntity;
  Function onFavorite = () {};

  @override
  State<ArtworkItemCollection> createState() => _ArtworkItemState();
}

class _ArtworkItemState extends State<ArtworkItemCollection> {
  _ArtworkItemState();

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
            builder: (context) => ArtworkDetailsPage(
                artworkEntity: widget.artworkEntity, borrowing: true),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF3F5F7),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Artwork Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: widget.artworkEntity.imageUrl != null
                  ? CustomNetworkImage(
                      imageUrl: widget.artworkEntity.imageUrl!,
                      width: 200,
                      height: 200,
                    )
                  : Container(
                      width: 200,
                      height: 200,
                      color: Colors.grey,
                      child: Icon(Icons.image, color: Colors.white),
                    ),
            ),
            const SizedBox(width: 12), // Space between image and text

            // Artwork Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    modifiedName,
                    style: TextStyles.bold16,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.artworkEntity.artist,
                    style: TextStyles.bold13.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    widget.artworkEntity.year.toString(),
                    style: TextStyles.semiBold13.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // "Borrow Artwork" Button
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement borrow functionality
                      print("Borrowing ${widget.artworkEntity.name}");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                    ),
                    child: Text(
                      "Borrow Artwork",
                      style: TextStyles.bold13.copyWith(color: Colors.white),
                    ),
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
