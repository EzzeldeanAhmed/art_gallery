import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/models/artwork_model.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/utils/ui_util.dart';
import 'package:art_gallery/features/home/dialogs/artwork_filters_dialog.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artwork_details_page.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/add_artwork_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ArtworksUpdateSearchPage extends StatefulWidget {
  const ArtworksUpdateSearchPage({Key? key, this.delete}) : super(key: key);
  static const routeName = 'artworksupdatesearch';
  final bool? delete;
  @override
  State<ArtworksUpdateSearchPage> createState() =>
      _ArtworksUpdateSearchPageState();
}

class _ArtworksUpdateSearchPageState extends State<ArtworksUpdateSearchPage> {
  String name = "";
  String epoch = '';
  String type = '';
  String artist = '';
  String sortBy = 'Name A -> Z';
  bool? forSale = null;
  String status = '';
  RangeValues yearRange = const RangeValues(500, 2025);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('artworks');
    // .where('status', whereIn: ['permanent', 'borrowed']);
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
            title: Card(
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
                    Positioned(
                      right: 0,
                      height: 56,
                      child: SizedBox(
                        width: 65,
                        child: ElevatedButton(
                          onPressed: () {
                            UiUtil.openBottomSheet(
                              context: context,
                              widget: ArtworkFiltersDialog(
                                sortBy: this.sortBy,
                                epoch: epoch,
                                type: type,
                                artist: artist,
                                yearRange: yearRange,
                                forSale: forSale,
                                onApplyFilter: (String sortBy,
                                    String epoch,
                                    String type,
                                    String artist,
                                    RangeValues yearRange,
                                    bool? forSale,
                                    String status) {
                                  setState(() {
                                    this.sortBy = sortBy;
                                    this.epoch = epoch;
                                    this.type = type;
                                    this.artist = artist;
                                    this.yearRange = yearRange;
                                    this.forSale = forSale;
                                    this.status = status;
                                  });
                                  debugPrint(
                                      'sortBy: $sortBy, epoch: $epoch, type: $type, artist: $artist, yearRange: $yearRange');
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            // iconColor: AppColors.primaryColor,
                          ),
                          child: SvgPicture.asset(
                            Assets.imagesFilter3,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primaryColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
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
                      data['id'] = snapshots.data!.docs[index].id;
                      if (data['id'] == "Eqwf9nXcGquHzaGmkRnT") {
                        debugPrint("data: $data");
                      }
                      if (data['name']
                              .toString()
                              .toLowerCase()
                              .contains(name.toLowerCase()) &&
                          (data['epoch'] == epoch || epoch == "") &&
                          (data['type'] == type || type == "") &&
                          (data['artist'] == artist || artist == "") &&
                          (data['year'] >= yearRange.start &&
                              data['year'] <= yearRange.end) &&
                          (forSale == null || data['forSale'] == forSale) &&
                          (status == "" || data['status'] == status) &&
                          data['status'] != 'other') {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => AddArtworkView(
                                      update: true,
                                      delete: widget.delete,
                                      defaultEntity: ArtworkModel.fromJson(data)
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
                            data['year'].toString(),
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
