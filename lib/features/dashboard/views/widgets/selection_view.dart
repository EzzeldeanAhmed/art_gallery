import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/artwork_dashboard_view.dart';
import 'package:art_gallery/features/dashboard/views/widgets/dashboard_operations.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/main_view.dart';
import 'package:flutter/material.dart';

class SelectionView extends StatelessWidget {
  const SelectionView({super.key});
  static const routeName = 'selection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromARGB(255, 123, 184, 234),
        appBar: AppBar(
          title: const Text('Art Musuem Gallery'),
        ),
        body: Center(
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 130,
                ),
                Center(
                  child: Text(
                    'Select an option',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                SizedBox(
                  height: 55,
                  width: 310,
                  child: CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MainView.routeName);
                    },
                    text: 'Log in as CLient',
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 55,
                  width: 310,
                  child: CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, DashboardOperations.routeName);
                    },
                    text: 'Log in as Admin',
                  ),
                ),
              ]),
        ));
  }
}
