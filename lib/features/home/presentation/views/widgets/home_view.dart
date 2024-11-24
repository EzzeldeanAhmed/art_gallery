import 'package:flutter/material.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = 'home_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemTapped: (int value) {},
      ),
      body: SafeArea(
        child: HomeViewBody(),
      ),
    );
  }
}