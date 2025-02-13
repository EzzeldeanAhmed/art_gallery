import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:art_gallery/core/models/exhibition_model.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/utils/ui_util.dart';
import 'package:art_gallery/features/home/dialogs/exhibition_filters_dialog.dart';
import 'package:art_gallery/features/home/dialogs/exhibition_filters_dialog.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/exhibtion_widgets/exhibition_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExhibitionsSearchPage extends StatefulWidget {
  const ExhibitionsSearchPage({Key? key}) : super(key: key);

  @override
  State<ExhibitionsSearchPage> createState() => _ExhibitionsSearchPageState();
}

class _ExhibitionsSearchPageState extends State<ExhibitionsSearchPage> {
  String name = "";
  String epoch = '';
  String type = '';
  String artist = '';
  String sortBy = 'Name A -> Z';
  RangeValues yearRange = const RangeValues(1500, 2025);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('exhibitions');
    var result;
    if (sortBy == "Name A -> Z") {
      result = collection.orderBy('name');
    } else if (sortBy == "Name Z -> A") {
      result = collection.orderBy('name', descending: true);
    } else if (sortBy == "Newest to Oldest") {
      result = collection.orderBy('year', descending: true);
    } else if (sortBy == "Oldest to Newest") {
      result = collection.orderBy('year');
    } else {
      result = collection;
    }

    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      /// Search Box
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(3),
                            child: SvgPicture.asset(
                              Assets.imagesSearchIcon,
                              colorFilter: const ColorFilter.mode(
                                AppColors.primaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(),
                          contentPadding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        textInputAction: TextInputAction.search,
                        autofocus: true,
                        onChanged: (String value) {
                          setState(() {
                            name = value;
                          });
                        },
                        // onFieldSubmitted: (v) {
                        //   Navigator.pushNamed(context, AppRoutes.searchResult);
                        // },
                      ),
                      // Positioned(
                      //   right: 0,
                      //   height: 56,
                      //   child: SizedBox(
                      //     width: 65,
                      //     child: ElevatedButton(
                      //       onPressed: () {
                      //         UiUtil.openBottomSheet(
                      //           context: context,
                      //           widget: ExhibitionFiltersDialog(
                      //             sortBy: this.sortBy,
                      //             epoch: epoch,
                      //             type: type,
                      //             artist: artist,
                      //             yearRange: yearRange,
                      //             onApplyFilter: (String sortBy,
                      //                 String epoch,
                      //                 String type,
                      //                 String artist,
                      //                 RangeValues yearRange) {
                      //               setState(() {
                      //                 this.sortBy = sortBy;
                      //                 this.epoch = epoch;
                      //                 this.type = type;
                      //                 this.artist = artist;
                      //                 this.yearRange = yearRange;
                      //               });
                      //             },
                      //           ),
                      //         );
                      //       },
                      //       style: ElevatedButton.styleFrom(
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(8),
                      //         ),
                      //         // iconColor: AppColors.primaryColor,
                      //       ),
                      //       child: SvgPicture.asset(
                      //         Assets.imagesFilter3,
                      //         colorFilter: const ColorFilter.mode(
                      //           AppColors.primaryColor,
                      //           BlendMode.srcIn,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: result.snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      if (data['name']
                              .toString()
                              .toLowerCase()
                              .contains(name.toLowerCase())
                          // &&
                          // (data['epoch'] == epoch || epoch == "") &&
                          // (data['type'] == type || type == "") &&
                          // (data['artist'] == artist || artist == "") &&
                          // (data['year'] >= yearRange.start &&
                          //     data['year'] <= yearRange.end)
                          ) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ExhibitionDetailsPage(
                                      exhibitionEntity:
                                          ExhibitionModel.fromJson(data)
                                              .toEntity())),
                            );
                          },
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            (data['startDate'] as Timestamp)
                                .toDate()
                                .toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['imageUrl']),
                          ),
                        );
                      }
                      return Container();
                    });
          },
        ));
  }
}
