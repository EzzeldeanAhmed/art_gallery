import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/widgets/artwork_dashboard_view_body.dart';
import 'package:flutter/material.dart';

class ArtworkDashboardView extends StatelessWidget {
  const ArtworkDashboardView({super.key});
  static const routeName = 'artwork_dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artworks Operations'),
        // leading: Image.asset(Assets.imagesMus),
        leadingWidth: 45,
      ),
      body: ArtworkDashboardViewBody(),
    );
  }
}
