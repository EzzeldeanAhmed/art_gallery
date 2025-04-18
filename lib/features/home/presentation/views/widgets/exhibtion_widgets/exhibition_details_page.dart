import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:art_gallery/core/repos/ticket_repo/ticket_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artwork_details_page.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/exhibtion_widgets/exhibition_book_popup.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/core/models/exhibition_entity.dart';
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
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold);
  static const contentStyleHeader = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  static const contentStyle = TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 16,
      fontWeight: FontWeight.bold);

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
                  headerPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                  sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  paddingBetweenClosedSections: 20,
                  disableScrolling: true,
                  children: [
                    AccordionSection(
                      isOpen: false,
                      contentVerticalPadding: 20,
                      // leftIcon: const Icon(Icons.text_fields_rounded,
                      //     color: Colors.white),
                      header: const Text('Start Date', style: headerStyle),
                      content: Text(
                          widget.exhibitionEntity.startDate.toString(),
                          style: contentStyle),
                    ),
                    AccordionSection(
                      isOpen: false,
                      contentVerticalPadding: 20,
                      // leftIcofn: const Icon(Icons.text_fields_rounded,
                      //     color: Colors.white),
                      header: const Text('End Date', style: headerStyle),
                      content: Text(widget.exhibitionEntity.endDate.toString(),
                          style: contentStyle),
                    ),
                    AccordionSection(
                      isOpen: false,
                      contentVerticalPadding: 20,
                      // leftIcon: const Icon(Icons.text_fields_rounded,
                      //     color: Colors.white),
                      header: const Text('Location', style: headerStyle),
                      content: Text(widget.exhibitionEntity.location,
                          style: contentStyle),
                    ),
                    AccordionSection(
                      isOpen: false,
                      contentVerticalPadding: 20,
                      // leftIcon: const Icon(Icons.text_fields_rounded,
                      //     color: Colors.white),
                      header: const Text('Museum Name', style: headerStyle),
                      content: Text(widget.exhibitionEntity.museumName,
                          style: contentStyle),
                    ),
                    AccordionSection(
                      isOpen: false,
                      contentVerticalPadding: 20,
                      // leftIcon: const Icon(Icons.text_fields_rounded,
                      //     color: Colors.white),
                      header: const Text('Overview', style: headerStyle),
                      content: Text(widget.exhibitionEntity.overview,
                          style: contentStyle),
                    ),
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                //   child: RichText(
                //     text: TextSpan(
                //       text: 'Start Date: ',
                //       style: TextStyles.semiBold16.copyWith(
                //         color: AppColors.secondaryColor,
                //       ),
                //       children: [
                //         TextSpan(
                //           text: widget.exhibitionEntity.startDate.toString(),
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
                //       text: 'End Date: ',
                //       style: TextStyles.semiBold16.copyWith(
                //         color: AppColors.secondaryColor,
                //       ),
                //       children: [
                //         TextSpan(
                //           text: widget.exhibitionEntity.endDate.toString(),
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
                //       text: 'Location: ',
                //       style: TextStyles.semiBold16.copyWith(
                //         color: AppColors.secondaryColor,
                //       ),
                //       children: [
                //         TextSpan(
                //           text: widget.exhibitionEntity.museumName,
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
                //       text: 'Country: ',
                //       style: TextStyles.semiBold16.copyWith(
                //         color: AppColors.secondaryColor,
                //       ),
                //       children: [
                //         TextSpan(
                //           text: widget.exhibitionEntity.location,
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
                //   child: StatefulBuilder(
                //     builder: (context, setState) {
                //       return Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           RichText(
                //             text: TextSpan(
                //               text: 'Overview: ',
                //               style: TextStyles.semiBold16.copyWith(
                //                 color: AppColors.secondaryColor,
                //               ),
                //             ),
                //           ),
                //           const SizedBox(height: 5),
                //           Text(
                //             widget.exhibitionEntity.overview,
                //             style: TextStyles.regular16.copyWith(
                //               color: AppColors.primaryColor,
                //             ),
                //             maxLines: isExpanded
                //                 ? null
                //                 : 1, // Show only 3 lines initially
                //             overflow: isExpanded
                //                 ? TextOverflow.visible
                //                 : TextOverflow.ellipsis,
                //           ),
                //           const SizedBox(height: 5),
                //           GestureDetector(
                //             onTap: () {
                //               setState(() {
                //                 isExpanded = !isExpanded;
                //               });
                //             },
                //             child: Text(
                //               isExpanded ? "Show Less" : "Show More",
                //               style: TextStyles.bold16.copyWith(
                //                 color: AppColors.primaryColor,
                //                 decoration: TextDecoration.underline,
                //               ),
                //             ),
                //           ),
                //         ],
                //       );
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: RichText(
                    text: TextSpan(
                      text: 'Participated Artworks: ',
                      style: TextStyles.semiBold16.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text:
                              '${widget.exhibitionEntity.artworks.length} artworks',
                          style: TextStyles.semiBold16.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
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
              ? SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the left
                    children: [
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                        child: Text(
                          'Attendees:',
                          style: TextStyles.bold23.copyWith(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('tickets')
                            .where('exhibitionId',
                                isEqualTo: widget.exhibitionEntity.id)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text("No attendees yet."),
                            );
                          }

                          // Extract user IDs and count tickets per user
                          Map<String, int> attendeeCounts = {};
                          int totalTickets = 0, counter = 1;
                          for (var doc in snapshot.data!.docs) {
                            String userId = doc['userId'] as String;
                            attendeeCounts[userId] =
                                (attendeeCounts[userId] ?? 0) + doc['quantity']
                                    as int;

                            totalTickets += doc['quantity'] as int;
                          }

                          return Column(
                            children: [
                              FutureBuilder(
                                future: getIt.get<AuthRepo>().getUsersData(
                                    uids: attendeeCounts.keys
                                        .toList()), // Fetch user details
                                builder: (context, userSnapshot) {
                                  if (userSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  if (!userSnapshot.hasData ||
                                      userSnapshot.data!.isEmpty) {
                                    return const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text("No attendees found."),
                                    );
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0),
                                    child: Column(
                                      children: userSnapshot.data!.map((user) {
                                        return Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              child: Text(
                                                "${counter++}", // First letter as avatar
                                                style:
                                                    TextStyles.bold16.copyWith(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              user.name,
                                              style: TextStyles.bold16.copyWith(
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                            trailing: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                color: AppColors.secondaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                'x${attendeeCounts[user.uId!]}', // Show ticket count
                                                style:
                                                    TextStyles.bold16.copyWith(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                  height: 15), // Spacing before total count
                              // Total Attendees Section
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    "Total Attendees: {$totalTickets}",
                                    style: TextStyles.bold19.copyWith(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
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
