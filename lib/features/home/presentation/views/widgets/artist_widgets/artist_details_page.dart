import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artwork_details_page.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/models/artwork_model.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArtistDetailsPage extends StatelessWidget {
  const ArtistDetailsPage({super.key, required this.artistEntity});

  final ArtistEntity artistEntity;

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(
        color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
    const contentStyleHeader = TextStyle(
        color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
    const contentStyle = TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontSize: 16,
        fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Art Museum Gallery',
          style: TextStyles.bold23.copyWith(
            color: Colors.black,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
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
                          ? CustomNetworkImage(
                              imageUrl: artistEntity.imageUrl!,
                            )
                          : Container(
                              color: Colors.grey,
                              height: 200,
                              width: double.infinity,
                              child: const Icon(Icons.image, size: 50),
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 25),
                  child: Center(
                    child: Text(
                      artistEntity.name,
                      style: TextStyles.bold19.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Accordion(
                  headerBorderColor: Colors.blueGrey,
                  headerBorderColorOpened: Colors.transparent,
                  // headerBorderWidth: 1,
                  headerBackgroundColorOpened: AppColors.primaryColor,
                  contentBackgroundColor: Colors.white,
                  contentBorderColor: AppColors.primaryColor,
                  contentBorderWidth: 5,
                  contentHorizontalPadding: 20,
                  scaleWhenAnimating: true,
                  openAndCloseAnimation: true,
                  paddingBetweenClosedSections: 20,
                  disableScrolling: true,
                  headerPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                  sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  children: [
                    AccordionSection(
                      isOpen: false,
                      contentVerticalPadding: 30,
                      // leftIcon: const Icon(Icons.text_fields_rounded,
                      //     color: Colors.white),
                      header: const Text('Country', style: headerStyle),
                      content: Text(artistEntity.country, style: contentStyle),
                    ),
                    AccordionSection(
                      isOpen: false,
                      contentVerticalPadding: 30,
                      // leftIcofn: const Icon(Icons.text_fields_rounded,
                      //     color: Colors.white),
                      header: const Text('Birth Date', style: headerStyle),
                      content: Text(artistEntity.BirthDate.toString(),
                          style: contentStyle),
                    ),
                    AccordionSection(
                      isOpen: false,
                      contentVerticalPadding: 30,
                      // leftIcon: const Icon(Icons.text_fields_rounded,
                      //     color: Colors.white),
                      header: const Text('Death Date', style: headerStyle),
                      content: Text(artistEntity.DeathDate.toString(),
                          style: contentStyle),
                    ),
                    AccordionSection(
                      isOpen: false,
                      contentVerticalPadding: 30,
                      // leftIcon: const Icon(Icons.text_fields_rounded,
                      //     color: Colors.white),
                      header: const Text('Century', style: headerStyle),
                      content: Text(artistEntity.century, style: contentStyle),
                    ),
                    AccordionSection(
                      isOpen: false,
                      contentVerticalPadding: 30,
                      // leftIcon: const Icon(Icons.text_fields_rounded,
                      //     color: Colors.white),
                      header: const Text('Biography', style: headerStyle),
                      content:
                          Text(artistEntity.biography, style: contentStyle),
                    ),
                    AccordionSection(
                      isOpen: false,
                      contentVerticalPadding: 30,
                      // leftIcon: const Icon(Icons.text_fields_rounded,
                      //     color: Colors.white),
                      header: const Text('Epoch', style: headerStyle),
                      content: Text(artistEntity.epoch, style: contentStyle),
                    ),
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                //   child: RichText(
                //     text: TextSpan(
                //       text: 'Country: ',
                //       style: TextStyles.semiBold16.copyWith(
                //         color: AppColors.secondaryColor,
                //       ),
                //       children: [
                //         TextSpan(
                //           text: artistEntity.country,
                //           style: TextStyles.semiBold16.copyWith(
                //             color: AppColors.primaryColor,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                //   child: RichText(
                //     text: TextSpan(
                //       text: 'Birth Date: ',
                //       style: TextStyles.semiBold16.copyWith(
                //         color: AppColors.secondaryColor,
                //       ),
                //       children: [
                //         TextSpan(
                //           text: artistEntity.BirthDate.toString(),
                //           style: TextStyles.semiBold16.copyWith(
                //             color: AppColors.primaryColor,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                //   child: RichText(
                //     text: TextSpan(
                //       text: 'Death Date: ',
                //       style: TextStyles.semiBold16.copyWith(
                //         color: AppColors.secondaryColor,
                //       ),
                //       children: [
                //         TextSpan(
                //           text: artistEntity.DeathDate,
                //           style: TextStyles.semiBold16.copyWith(
                //             color: AppColors.primaryColor,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                //   child: RichText(
                //     text: TextSpan(
                //       text: 'Century: ',
                //       style: TextStyles.semiBold16.copyWith(
                //         color: AppColors.secondaryColor,
                //       ),
                //       children: [
                //         TextSpan(
                //           text: artistEntity.century,
                //           style: TextStyles.semiBold16.copyWith(
                //             color: AppColors.primaryColor,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                //   child: RichText(
                //     text: TextSpan(
                //       text: 'Biography: ',
                //       style: TextStyles.semiBold16.copyWith(
                //         color: AppColors.secondaryColor,
                //       ),
                //       children: [
                //         TextSpan(
                //           text: artistEntity.biography,
                //           style: TextStyles.regular16.copyWith(
                //             color: AppColors.primaryColor,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                //   child: RichText(
                //     text: TextSpan(
                //       text: 'Epoch: ',
                //       style: TextStyles.semiBold16.copyWith(
                //         color: AppColors.secondaryColor,
                //       ),
                //       children: [
                //         TextSpan(
                //           text: artistEntity.epoch,
                //           style: TextStyles.semiBold16.copyWith(
                //             color: AppColors.primaryColor,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 5),
                  child: RichText(
                    text: TextSpan(
                      text: 'Artworks: ',
                      style: TextStyles.bold23.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('artworks')
                .where("artist", isEqualTo: artistEntity.name)
                .snapshots(),
            builder: (context, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshots.hasData && snapshots.data!.docs.isNotEmpty) {
                final artworks = snapshots.data!.docs
                    .map((e) =>
                        ArtworkModel.fromJson(e.data() as Map<String, dynamic>)
                            .toEntity())
                    .toList();

                return SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final artwork = artworks[index];
                        return GestureDetector(
                          onTap: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ArtworkDetailsPage(
                                      artworkEntity: artwork)),
                            )
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child: artwork.imageUrl != null
                                        ? CustomNetworkImage(
                                            imageUrl: artwork.imageUrl!,
                                          )
                                        : Container(
                                            color: Colors.grey,
                                            child: const Icon(
                                              Icons.image,
                                              size: 50,
                                            ),
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    artwork.name,
                                    style: TextStyles.bold16,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    artwork.year.toString(),
                                    style: TextStyles.regular13.copyWith(
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: artworks.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                  ),
                );
              }

              return const SliverToBoxAdapter(
                child: Center(
                  child: Text("No artworks found."),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
