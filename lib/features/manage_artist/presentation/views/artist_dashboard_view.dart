import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/widgets/artist_dashboard_view_body.dart';
import 'package:flutter/material.dart';

class ArtistDashboardView extends StatelessWidget {
  const ArtistDashboardView({super.key});
  static const routeName = 'artist_dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artists Operations'),
        // leading: Image.asset(Assets.imagesMus),
        leadingWidth: 45,
      ),
      body: ArtistDashboardViewBody(),
    );
  }
}
