import 'package:flutter/material.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';

AppBar buildAppbar(context, {required String title}) {
  return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_new),
      ),
      centerTitle: true,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyles.bold19,
      ));
}
