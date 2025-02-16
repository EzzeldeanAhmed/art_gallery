import 'package:art_gallery/core/repos/ticket_repo/ticket_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artwork_details_page.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/exhibtion_widgets/exhibition_book_popup.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/models/artwork_model.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/widgets/custom_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExhibitionDetailsPage extends StatefulWidget {
  const ExhibitionDetailsPage(
      {super.key, required this.exhibitionEntity, required this.filter});

  final ExhibitionEntity exhibitionEntity;
  final String filter;

  @override
  State<ExhibitionDetailsPage> createState() => _ExhibitionDetailsPageState();
}

class _ExhibitionDetailsPageState extends State<ExhibitionDetailsPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
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
                      child: widget.exhibitionEntity.imageUrl != null
                          ? CustomNetworkImage(
                              imageUrl: widget.exhibitionEntity.imageUrl!,
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
                      widget.exhibitionEntity.name,
                      style: TextStyles.bold19.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: RichText(
                    text: TextSpan(
                      text: 'Start Date: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.exhibitionEntity.startDate.toString(),
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
                      text: 'End Date: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.exhibitionEntity.endDate.toString(),
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
                      text: 'Location: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.exhibitionEntity.museumName,
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
                      text: 'Country: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: widget.exhibitionEntity.location,
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
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Overview: ',
                              style: TextStyles.semiBold16.copyWith(
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.exhibitionEntity.overview,
                            style: TextStyles.regular16.copyWith(
                              color: AppColors.primaryColor,
                            ),
                            maxLines: isExpanded
                                ? null
                                : 1, // Show only 3 lines initially
                            overflow: isExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Text(
                              isExpanded ? "Show Less" : "Show More",
                              style: TextStyles.bold16.copyWith(
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
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
          widget.exhibitionEntity.artworks.isEmpty
              ? const SliverToBoxAdapter(
                  child: Center(
                    child: Text("No artworks found."),
                  ),
                )
              : StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('artworks')
                      .where(FieldPath.documentId,
                          whereIn: widget.exhibitionEntity.artworks)
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
                          .map((e) => ArtworkModel.fromJson(
                                  e.data() as Map<String, dynamic>)
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
                                        builder: (context) =>
                                            ArtworkDetailsPage(
                                                artworkEntity: artwork)),
                                  )
                                },
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(12),
                                          ),
                                          child: artwork.imageUrl != null
                                              ? CustomNetworkImage(
                                                  imageUrl: artwork.imageUrl!)
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
          // Book a Ticket Button at the Bottom
          widget.filter == "past"
              ? const SliverToBoxAdapter(
                  child: SizedBox.shrink(),
                )
              : SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        // Handle booking action
                        var ticketRepo = getIt.get<TicketRepo>();
                        var ticketCount = await ticketRepo
                            .getTicketsByExhibitionId(
                                exhibitionId: widget.exhibitionEntity.id!)
                            .then((value) =>
                                value.fold((l) => 0, (r) => r.length));
                        showBookTicketPopup(context, widget.exhibitionEntity,
                            widget.exhibitionEntity.capacity - ticketCount);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1F5E3B), // Button color
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Book a Ticket',
                        style: TextStyles.bold16.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
