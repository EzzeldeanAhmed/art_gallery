import 'package:art_gallery/core/widgets/custom_button.dart';
import 'package:art_gallery/features/dashboard/views/widgets/system_basic_entites.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/widgets/collection_list_view_bloc_builder.dart';
import 'package:art_gallery/features/manage_users/manage_users.dart';
import 'package:art_gallery/features/reports/reports_list.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:art_gallery/features/auth/presentation/views/signin_view.dart';
import 'package:art_gallery/core/services/get_it_service.dart';

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
            const SizedBox(height: 200),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, SystemBasicEntites.routeName);
              },
              text: 'Maintain Basic Data',
            ),
            const SizedBox(height: 30),
            CustomButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CollectionsView()));
              },
              text: "Borrow From",
            ),
            const SizedBox(height: 30),
            CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ManageUsersScreen()));
              },
              text: 'Manage Users',
            ),
            const SizedBox(height: 30),
            CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReportsListScreen()));
              },
              text: "Generate Report",
            ),
          ],
        ),
      ),

      // Floating Action Button for Logout
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () => {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Logout'),
                    onPressed: () {
                      getIt.get<AuthRepo>().deleteSavedUserData();
                      Navigator.pushNamedAndRemoveUntil(
                          context, SigninView.routeName, (route) => false);
                    },
                  ),
                ],
              ),
            )
          },
          backgroundColor: Colors.red,
          tooltip: 'Logout',
          child: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
