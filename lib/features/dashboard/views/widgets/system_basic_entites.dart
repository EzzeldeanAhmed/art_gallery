import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/features/dashboard/views/dashboard_view.dart';
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
            CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, DashboardView.routeName);
                },
                text: 'Artworks'),
            SizedBox(height: 30),
            CustomButton(onPressed: () {}, text: 'Artists'),
            SizedBox(height: 30),
            CustomButton(onPressed: () {}, text: 'Exhibitions'),
            SizedBox(height: 30),
            CustomButton(onPressed: () {}, text: 'Collections'),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
