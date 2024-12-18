import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/features/add_artwork/presentation/views/add_artwork_view.dart';
import 'package:flutter/material.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, AddArtworkView.routeName);
              },
              text: "Add Data")
        ],
      ),
    );
  }
}
