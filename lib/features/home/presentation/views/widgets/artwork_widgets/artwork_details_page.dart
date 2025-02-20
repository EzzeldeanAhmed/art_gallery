import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/artist_model.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/models/collection_entity.dart';
import 'package:art_gallery/core/repos/artist_repo/artist_repo.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/repos/collection_repo/collection_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_network_image.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artist_widgets/artist_details_page.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/widgets/collection_borrow_popup.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/widgets/collection_return_popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ArtworkDetailsPage extends StatefulWidget {
  ArtworkDetailsPage(
      {super.key,
      required this.artworkEntity,
      this.borrowing = false,
      Function? addToCart});

  final ArtworkEntity artworkEntity;
  bool? borrowing = false;
  CollectionEntity? collection;
  Function? addToCart = () {};

  @override
  State<ArtworkDetailsPage> createState() => _ArtworkDetailsPageState();
}

Future<CollectionEntity> getCollection(String id) async {
  return await getIt.get<CollectionsRepo>().getCollectionById(id);
}

class _ArtworkDetailsPageState extends State<ArtworkDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text(artworkEntity.name),
          title: Text(
            'Art Museum Gallery',
            style: TextStyles.bold23.copyWith(
              color: Colors.black,
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: Hero(
                    tag: 'dd',
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: widget.artworkEntity.imageUrl != null
                          ? Flexible(
                              child: CustomNetworkImage(
                                  imageUrl: widget.artworkEntity.imageUrl!),
                            )
                          : Container(
                              color: Colors.grey,
                              height: 100,
                              width: 100,
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 25),
                  child: Center(
                    child: Text(
                      widget.artworkEntity.name,
                      //textAlign: TextAlign.center,
                      style: TextStyles.bold19.copyWith(
                        color: Colors.black,
                        /*color: AppColors.primaryColor,*/
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: RichText(
                    text: TextSpan(
                      text: 'Type: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.artworkEntity.type,
                          style: TextStyles.semiBold16.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: RichText(
                    text: TextSpan(
                      text: 'Year made: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.artworkEntity.year.toString(),
                          style: TextStyles.semiBold16.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("artists")
                            .where("name",
                                isEqualTo: widget.artworkEntity.artist)
                            .snapshots(),
                        builder: (context, snapshots) {
                          return (snapshots.connectionState ==
                                  ConnectionState.waiting)
                              ? RichText(
                                  text: TextSpan(
                                    text: 'Artist: ',
                                    style: TextStyles.semiBold16.copyWith(
                                      color: AppColors.secondaryColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {},
                                        text: widget.artworkEntity.artist,
                                        style: TextStyles.semiBold16.copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : RichText(
                                  text: TextSpan(
                                    text: 'Artist: ',
                                    style: TextStyles.semiBold16.copyWith(
                                      color: AppColors.secondaryColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            final data = snapshots
                                                .data!.docs.first
                                                .data() as Map<String, dynamic>;

                                            ArtistEntity artist =
                                                ArtistModel.fromJson(data)
                                                    .toEntity();

                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ArtistDetailsPage(
                                                          artistEntity:
                                                              artist)),
                                            );
                                          },
                                        text: widget.artworkEntity.artist,
                                        style: TextStyles.semiBold16.copyWith(
                                          color: const Color.fromARGB(
                                              255, 19, 6, 255),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        })),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: RichText(
                    text: TextSpan(
                      text: 'Medium: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.artworkEntity.medium,
                          style: TextStyles.semiBold16.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: RichText(
                    text: TextSpan(
                      text:
                          'Description:                                                                 ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.artworkEntity.description,
                          style: TextStyles.regular16.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: RichText(
                    text: TextSpan(
                      text: 'Country of Origin: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.artworkEntity.country,
                          style: TextStyles.semiBold16.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: RichText(
                    text: TextSpan(
                      text: 'Dimensions: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.artworkEntity.dimensions,
                          style: TextStyles.semiBold16.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: RichText(
                    text: TextSpan(
                      text: 'Epoch: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.artworkEntity.epoch,
                          style: TextStyles.semiBold16.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FutureBuilder(
                    future: getCollection(widget.artworkEntity.collectionID!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var collection = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                          child: RichText(
                            text: TextSpan(
                              text: 'Status: ',
                              style: TextStyles.semiBold16.copyWith(
                                color: AppColors.secondaryColor,
                              ),
                              children: [
                                TextSpan(
                                  text: widget.artworkEntity.status == "other"
                                      ? "Belongs to ${collection!.name} collection"
                                      : widget.artworkEntity.status ==
                                              "borrowed"
                                          ? "Borrowed from ${collection!.name} collection"
                                          : "Permanent Artwork",
                                  style: TextStyles.semiBold16.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
                widget.artworkEntity.forSale!
                    ? Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: widget.addToCart as void Function()?,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Add to Cart",
                              style: TextStyles.bold16.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                widget.borrowing!
                    ? Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: SizedBox(
                          width: double.infinity, // Makes the button full-width
                          child: ElevatedButton(
                            onPressed: () async {
                              if (widget.artworkEntity.status == 'borrowed') {
                                // Return artwork
                                showReturnArtworkPopup(
                                    context, widget.artworkEntity, () {
                                  var artworkRepo = getIt.get<ArtworksRepo>();
                                  setState(() {
                                    widget.artworkEntity.status = 'other';
                                    widget.artworkEntity.returnDate = null;
                                    widget.artworkEntity.borrowDate = null;
                                    artworkRepo
                                        .updateArtwork(widget.artworkEntity);
                                  });
                                });
                              } else {
                                showBorrowArtworkPopup(
                                    context, widget.artworkEntity,
                                    (returnDate) {
                                  var artworkRepo = getIt.get<ArtworksRepo>();
                                  setState(() {
                                    widget.artworkEntity.status = 'borrowed';
                                    widget.artworkEntity.borrowDate =
                                        DateTime.now();
                                    widget.artworkEntity.returnDate =
                                        returnDate;
                                    artworkRepo
                                        .updateArtwork(widget.artworkEntity);
                                  });
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  widget.artworkEntity.status == 'borrowed'
                                      ? AppColors.secondaryColor
                                      : AppColors.primaryColor, // Button color
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              widget.artworkEntity.status == 'borrowed'
                                  ? "Return Artwork"
                                  : "Borrow Artwork",
                              style: TextStyles.bold16.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ))
          ],
        ));
  }
}
