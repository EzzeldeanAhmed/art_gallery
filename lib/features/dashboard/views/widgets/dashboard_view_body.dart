import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/add_artwork_view.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/widgets/artworks_update_search_page.dart';
import 'package:flutter/material.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          const Text(
            'Manage Artwork',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 50),
          CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AddArtworkView(delete: false, update: false),
                ));
              },
              text: "Add ArtWork"),
          SizedBox(
            height: 30,
          ),
          CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArtworksUpdateSearchPage(delete: false),
                ));
              },
              text: "Update ArtWork"),
          SizedBox(
            height: 30,
          ),
          CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArtworksUpdateSearchPage(delete: true),
                ));
              },
              text: "Delete ArtWork")
        ],
      ),
    );
  }
}
