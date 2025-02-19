import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/artist_model.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/repos/artist_repo/artist_repo.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_network_image.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artist_widgets/artist_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ArtworkDetailsPage extends StatelessWidget {
  ArtworkDetailsPage({super.key, required this.artworkEntity, this.borrowing});

  final ArtworkEntity artworkEntity;
  bool? borrowing = false;
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
                      child: artworkEntity.imageUrl != null
                          ? Flexible(
                              child: CustomNetworkImage(
                                  imageUrl: artworkEntity.imageUrl!),
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
                      artworkEntity.name,
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
                          text: artworkEntity.type,
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
                          text: artworkEntity.year.toString(),
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
                            .where("name", isEqualTo: artworkEntity.artist)
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
                                        text: artworkEntity.artist,
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
                                        text: artworkEntity.artist,
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
                          text: artworkEntity.medium,
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
                          text: artworkEntity.description,
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
                          text: artworkEntity.country,
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
                          text: artworkEntity.dimensions,
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
                          text: artworkEntity.epoch,
                          style: TextStyles.semiBold16.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 22),
                borrowing!
                    ? Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: SizedBox(
                          width: double.infinity, // Makes the button full-width
                          child: ElevatedButton(
                            onPressed: () async {
                              // Handle booking action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xff1F5E3B), // Button color
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Borrow Artwork',
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


                /* Type
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                  child: Text(
                    'Type: ${artworkEntity.type}',
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                */
                /* Year
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: Text(
                    artworkEntity.year.toString(),
                    style: TextStyles.bold19.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),*/
                
                
                /* Artist
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                  child: Text(
                    artworkEntity.artist,
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
                */

                //Medium
                /*Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                  child: Text(
                    artworkEntity.medium,
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),*/

                //description
                /*Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
                  child: Text(
                    artworkEntity.description,
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),*/

                //Country
                /*Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                  child: Text(
                    artworkEntity.country,
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),*/

                //dimensions
                /*Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                  child: Text(
                    artworkEntity.dimensions,
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),*/

                //epoch
                /* Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                  child: Text(
                    artworkEntity.epoch,
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),*/