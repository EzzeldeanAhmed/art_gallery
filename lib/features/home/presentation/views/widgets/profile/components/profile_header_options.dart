import 'package:art_gallery/core/utils/app_icons.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_favorites/favorites_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/order_widgets/order_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/profile/booked_tickets/tickets.dart';
import 'package:flutter/material.dart';

import 'profile_squre_tile.dart';

class ProfileHeaderOptions extends StatelessWidget {
  const ProfileHeaderOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ProfileSqureTile(
            label: 'Ticktes',
            icon: AppIcons.tickets,
            type: "png",
            onTap: () {
              Navigator.pushNamed(context, TicketListScreen.routeName);
            },
          ),
          ProfileSqureTile(
            label: 'Favorites',
            icon: AppIcons.favprof,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoritesView(
                            profile: true,
                          )));
            },
          ),
          ProfileSqureTile(
            label: 'Orders',
            icon: AppIcons.order,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderView()));
            },
          ),
        ],
      ),
    );
  }
}
