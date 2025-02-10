import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/widgets/artist_dashboard_view_body.dart';
import 'package:art_gallery/features/manage_exhibition/presentation/views/widgets/exhibition_dashboard_view_body.dart';
import 'package:flutter/material.dart';

class ExhibitionDashboardView extends StatelessWidget {
  const ExhibitionDashboardView({super.key});
  static const routeName = 'exhibition_dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exhibitions Operations'),
        // leading: Image.asset(Assets.imagesMus),
        leadingWidth: 45,
      ),
      body: ExhibitionDashboardViewBody(),
    );
  }
}
