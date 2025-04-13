import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/add_collection_view.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/widgets/collection_list_view_bloc_builder.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/widgets/collection_update_search_page.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/widgets/collections_list_view.dart';
import 'package:flutter/material.dart';

class CollectionDashboardViewBody extends StatelessWidget {
  const CollectionDashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 180,
          ),
          const Text(
            'Manage Collection',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 50),
          CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AddCollectionView(delete: false, update: false),
                ));
              },
              text: "Add Collection"),
          SizedBox(
            height: 30,
          ),
          CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      CollectionsUpdateSearchPage(delete: false),
                ));
              },
              text: "Update Collection"),
          SizedBox(
            height: 30,
          ),
          CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      CollectionsUpdateSearchPage(delete: true),
                ));
              },
              text: "Delete Collection"),
        ],
      ),
    );
  }
}
