import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/widgets/custom_network_image.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter/material.dart';

import 'profile_header_options.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background
        Image.asset('assets/images/profile_page_background.png'),

        /// Content
        Column(
          children: [
            AppBar(
              title: const Text('Profile'),
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const _UserData(),
            const ProfileHeaderOptions()
          ],
        ),
      ],
    );
  }
}

class _UserData extends StatelessWidget {
  const _UserData();

  @override
  Widget build(BuildContext context) {
    var user = getIt.get<AuthRepo>().getSavedUserData();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const SizedBox(width: 16),
          SizedBox(
            width: 100,
            height: 100,
            child: ClipOval(
                child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.asset(
                      Assets.imagesUserPicture,
                      width: 50,
                      height: 50,
                    ))),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                user.email,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
