import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

class ArtistDetailsPage extends StatelessWidget {
  const ArtistDetailsPage({super.key, required this.artistEntity});

  final ArtistEntity artistEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text(artistEntity.name),
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
                      child: artistEntity.imageUrl != null
                          ? Flexible(
                              child: CustomNetworkImage(
                                  imageUrl: artistEntity.imageUrl!),
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
                      artistEntity.name,
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
                      text: 'Country: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: artistEntity.country,
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
                      text: 'Birth Date: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: artistEntity.BirthDate.toString(),
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
                      text: 'Death Date: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: artistEntity.DeathDate,
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
                      text: 'Century: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: artistEntity.century,
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
                      text: 'Biography: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: artistEntity.biography,
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
                      text: 'Epoch: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: artistEntity.epoch,
                          style: TextStyles.semiBold16.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 34),
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
                    'Type: ${artistEntity.type}',
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
                    artistEntity.year.toString(),
                    style: TextStyles.bold19.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),*/
                
                
                /* Artist
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                  child: Text(
                    artistEntity.artist,
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
                    artistEntity.medium,
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),*/

                //description
                /*Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
                  child: Text(
                    artistEntity.description,
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),*/

                //Country
                /*Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                  child: Text(
                    artistEntity.country,
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),*/

                //dimensions
                /*Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                  child: Text(
                    artistEntity.dimensions,
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),*/

                //epoch
                /* Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                  child: Text(
                    artistEntity.epoch,
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),*/