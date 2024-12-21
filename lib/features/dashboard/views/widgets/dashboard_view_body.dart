import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/add_artwork_view.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/widgets/artworks_update_search_page.dart';
import 'package:flutter/material.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, AddArtworkView.routeName);
              },
              text: "Add ArtWork"),
          SizedBox(
            height: 20,
          ),
          CustomButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, ArtworksUpdateSearchPage.routeName);
              },
              text: "Update ArtWork"),
          SizedBox(
            height: 20,
          ),
          CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, AddArtworkView.routeName);
              },
              text: "Delete ArtWork")
        ],
      ),
    );
  }
}
