import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/artist_model.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/models/artwork_model.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/utils/ui_util.dart';
import 'package:art_gallery/features/home/dialogs/artist_filters_dialog.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artist_widgets/artist_details_page.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artwork_details_page.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/widgets/add_artwork_view_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ArtistsSearchPage extends StatefulWidget {
  const ArtistsSearchPage({Key? key}) : super(key: key);

  @override
  State<ArtistsSearchPage> createState() => _ArtistsSearchPageState();
}

class _ArtistsSearchPageState extends State<ArtistsSearchPage> {
  String name = "";
  String epoch = "";
  String sortBy = "Name A -> Z";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('artists');
    var result;
    if (sortBy == "Name A -> Z") {
      result = collection.orderBy('name');
    } else if (sortBy == "Name Z -> A") {
      result = collection.orderBy('name', descending: true);
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
                      Positioned(
                        right: 0,
                        height: 56,
                        child: SizedBox(
                          width: 65,
                          child: ElevatedButton(
                            onPressed: () {
                              UiUtil.openBottomSheet(
                                context: context,
                                widget: ArtistFiltersDialog(
                                  sortBy: sortBy,
                                  epoch: epoch,
                                  onApplyFilter: (sortBy, epoch) {
                                    setState(() {
                                      this.sortBy = sortBy;
                                      this.epoch = epoch;
                                    });
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
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: result.snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting ||
                    snapshots.data == null)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;
                      // Sort Data

                      if ((data['name']
                                  .toString()
                                  .toLowerCase()
                                  .contains(name.toLowerCase()) ||
                              data['country']
                                  .toString()
                                  .toLowerCase()
                                  .contains(name.toLowerCase())) &&
                          (data['epoch'] == epoch || epoch == "")) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ArtistDetailsPage(
                                      artistEntity: ArtistModel.fromJson(data)
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
                            data['country'],
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
