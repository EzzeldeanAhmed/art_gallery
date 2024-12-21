import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/features/dashboard/views/widgets/system_basic_entites.dart';
import 'package:flutter/material.dart';

class DashboardOperations extends StatelessWidget {
  const DashboardOperations({super.key});
  static const routeName = 'dashboard_operations';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Operations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, SystemBasicEntites.routeName);
              },
              text: 'Maintain Basic Data'),
        ),
      ),
    );
  }
}
