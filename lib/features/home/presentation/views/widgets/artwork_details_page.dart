import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

class ArtworkDetailsPage extends StatelessWidget {
  const ArtworkDetailsPage({super.key, required this.artworkEntity});

  final ArtworkEntity artworkEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text(artworkEntity.name),
          title: Text(
            'ArtsHUB',
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
                  child: RichText(
                    text: TextSpan(
                      text: 'Artist: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: artworkEntity.artist,
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