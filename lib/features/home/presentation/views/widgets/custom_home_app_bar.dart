import 'package:flutter/material.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //trailing: const NotificationWidget(),
      contentPadding: EdgeInsets.all(12),
      leading: Image.asset(Assets.imagesProfileImage),
      title: Text(
        'WELCOME TO OUR APPLICATION',
        textAlign: TextAlign.left,
        style: TextStyles.semiBold16.copyWith(
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      /* subtitle: Text(
        getUser().name,
        textAlign: TextAlign.right,
        style: TextStyles.bold16, */
    );
  }
}
