import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/widgets/artist_dashboard_view_body.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/widgets/collection_dashboard_view_body.dart';
import 'package:flutter/material.dart';

class CollectionDashboardView extends StatelessWidget {
  const CollectionDashboardView({super.key});
  static const routeName = 'collection_dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections Operations'),
        // leading: Image.asset(Assets.imagesMus),
        leadingWidth: 45,
      ),
      body: CollectionDashboardViewBody(),
    );
  }
}
