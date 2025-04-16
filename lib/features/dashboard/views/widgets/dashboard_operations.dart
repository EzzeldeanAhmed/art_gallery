import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/features/dashboard/views/widgets/system_basic_entites.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/widgets/collection_list_view_bloc_builder.dart';
import 'package:art_gallery/features/reports/reports_list.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            SizedBox(
              height: 280,
            ),
            CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, SystemBasicEntites.routeName);
                },
                text: 'Maintain Basic Data'),
            SizedBox(
              height: 30,
            ),
            CustomButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CollectionsView()));
                },
                text: "Borrow From"),
            SizedBox(
              height: 30,
            ),
            CustomButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReportsListScreen()));
                },
                text: "Generate Report"),
          ],
        ),
      ),
    );
  }
}
