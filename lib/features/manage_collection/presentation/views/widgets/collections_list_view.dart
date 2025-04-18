import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/models/artwork_model.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/widgets/artworks_grid_view_collection.dart';
import 'package:flutter/material.dart';

class CollectionsListView extends StatelessWidget {
  final List<Map<String, dynamic>> collections;

  const CollectionsListView({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Art Collections',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightPrimaryColor,
      ),
      body: collections.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Accordion(
              headerBorderColor: AppColors.lightPrimaryColor,
              headerBorderColorOpened: AppColors.lightPrimaryColor,
              // headerBorderWidth: 1,
              headerBackgroundColor: AppColors.lightPrimaryColor,
              headerBackgroundColorOpened: AppColors.lightPrimaryColor,
              contentBackgroundColor: Colors.white,
              contentBorderColor: AppColors.lightPrimaryColor,
              contentBorderWidth: 3,
              contentHorizontalPadding: 20,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: collections.map(
                (collection) {
                  return AccordionSection(
                    paddingBetweenClosedSections: 32,
                    paddingBetweenOpenSections: 32,
                    isOpen: false,
                    header: Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(15),
                        title: Text(
                          collection['collection'].name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${collection['artworks'].length} artworks',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                        leading: Icon(Icons.collections,
                            color: AppColors.lightPrimaryColor),
                        onTap: () {
                          // Handle navigation or actions when tapped
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ArtworksGridViewCollection(
                                        artworks:
                                            (collection['artworks'] as List),
                                        collection: collection['collection'],
                                      )));
                        },
                      ),
                    ),
                    content: Text(collection['collection'].overview),
                  );
                },
              ).toList(),
            ),
    );
  }
}
