import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/artist_dashboard_view.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/artwork_dashboard_view.dart';
import 'package:flutter/material.dart';

class SystemBasicEntites extends StatelessWidget {
  const SystemBasicEntites({super.key});
  static const routeName = 'basic_entites';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Basic Entities'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300, // Set a smaller width
              height: 50,
              child: CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, ArtworkDashboardView.routeName);
                  },
                  text: 'Artworks'),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 300, // Set a smaller width
              height: 50,
              child: CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ArtistDashboardView.routeName);
                  },
                  text: 'Artists'),
            ),
            SizedBox(height: 30),
            SizedBox(
                width: 300, // Set a smaller width
                height: 50,
                child: CustomButton(onPressed: () {}, text: 'Exhibitions')),
            SizedBox(height: 30),
            SizedBox(
                width: 300, // Set a smaller width
                height: 50,
                child: CustomButton(onPressed: () {}, text: 'Collections')),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
