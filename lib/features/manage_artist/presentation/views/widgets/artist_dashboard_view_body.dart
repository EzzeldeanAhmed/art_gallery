import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/add_artist_view.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/widgets/artists_update_search_page.dart';
import 'package:flutter/material.dart';

class ArtistDashboardViewBody extends StatelessWidget {
  const ArtistDashboardViewBody({super.key});

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
            'Manage Artist',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 50),
          CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AddArtistView(delete: false, update: false),
                ));
              },
              text: "Add Artist"),
          SizedBox(
            height: 30,
          ),
          CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArtistsUpdateSearchPage(delete: false),
                ));
              },
              text: "Update Artist"),
          SizedBox(
            height: 30,
          ),
          CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ArtistsUpdateSearchPage(delete: true),
                ));
              },
              text: "Delete Artist")
        ],
      ),
    );
  }
}
