import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(12),
      leading: Image.asset(Assets.imagesMus),
      title: Text(
        'Welcome To Art Museum Gallery',
        //textAlign: TextAlign.center,
        style: TextStyles.bold19.copyWith(
          //color: AppColors.primaryColor
          color: Colors.black,
        ),
      ),

      /* subtitle: Text(
        getUser().name,
        textAlign: TextAlign.right,
        style: TextStyles.bold16, */
    );
  }
}
