import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/features/dashboard/views/widgets/dashboard_view_body.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  static const routeName = 'dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artworks Operations'),
        leading: Image.asset(Assets.imagesMus),
        leadingWidth: 45,
      ),
      body: DashboardViewBody(),
    );
  }
}
