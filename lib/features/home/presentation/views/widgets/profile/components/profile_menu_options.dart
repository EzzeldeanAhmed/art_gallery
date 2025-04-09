import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/utils/app_icons.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:art_gallery/features/auth/presentation/views/signin_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/payment_widgets/payment_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/profile/booked_tickets/tickets.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/profile/profile_edit_page.dart';
import 'package:flutter/material.dart';

import 'profile_list_tile.dart';

class ProfileMenuOptions extends StatelessWidget {
  const ProfileMenuOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ProfileListTile(
            title: 'My Profile',
            icon: AppIcons.profilePerson,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileEditPage()));
            },
          ),
          // const Divider(thickness: 0.1),
          // ProfileListTile(
          //   title: 'Notification',
          //   // icon: AppIcons.profileNotification,
          //   icon: AppIcons.profileNotification,
          //   onTap: () {
          //     // Navigator.pushNamed(context, AppRoutes.notifications)
          //   },
          // ),
          // const Divider(thickness: 0.1),
          // ProfileListTile(
          //   title: 'Setting',
          //   icon: Icons.abc.toString(),
          //   // icon: AppIcons.profileSetting,
          //   onTap: () => {
          //     // Navigator.pushNamed(context, AppRoutes.settings)
          //   },
          // ),
          //const Divider(thickness: 0.1),
          // ProfileListTile(
          //   title: 'Payment',
          //   icon: AppIcons.profilePayment,
          //   onTap: () {
          //     //  Navigator.pushNamed(context, AppRoutes.paymentMethod)
          //   },
          // ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Payments',
            icon: AppIcons.profilePayment,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaymentsView()));
              //  Navigator.pushNamed(context, AppRoutes.loginOrSignup)
            },
          ),
          const Divider(thickness: 0.1),
          ProfileListTile(
            title: 'Logout',
            icon: AppIcons.profileLogout,
            onTap: () {
              // confirm
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
              );
            },
          ),
        ],
      ),
    );
  }
}
