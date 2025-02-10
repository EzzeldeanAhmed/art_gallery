import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/add_artist_view.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/widgets/artists_update_search_page.dart';
import 'package:art_gallery/features/manage_exhibition/presentation/views/add_exhibition_view.dart';
import 'package:art_gallery/features/manage_exhibition/presentation/views/widgets/exhibition_update_search_page.dart';
import 'package:flutter/material.dart';

class ExhibitionDashboardViewBody extends StatelessWidget {
  const ExhibitionDashboardViewBody({super.key});

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
            'Manage Exhibition',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 50),
          CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AddExhibitionView(delete: false, update: false),
                ));
              },
              text: "Add Exhibition"),
          SizedBox(
            height: 30,
          ),
          CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ExhibitionUpdateSearchPage(delete: false),
                ));
              },
              text: "Update Exhibition"),
          SizedBox(
            height: 30,
          ),
          CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ExhibitionUpdateSearchPage(delete: true),
                ));
              },
              text: "Delete Exhibition")
        ],
      ),
    );
  }
}
