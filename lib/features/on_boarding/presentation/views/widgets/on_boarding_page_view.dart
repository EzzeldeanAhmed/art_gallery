import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/features/on_boarding/presentation/views/widgets/page_view_item.dart';
import 'package:fruits_hub/core/utils/app_textstyles.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        PageViewItem(
          isVisible: true,
          image: Assets.imagesPageViewItem1Image,
          backgroundImage: Assets.imagesPageViewItem1BackgroundImage,
          subtitle:
              "Explore a world of fresh, high-quality fruits,handpicked just for you, Bringing farm-fresh fruits to your doorstep with ease and convenience.Enjoy the taste of nature with our wide selection of seasonal and exotic fruits.",
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome To ',
                style: TextStyles.bold23,
              ),
              Text(
                'Fruit',
                style:
                    TextStyles.bold23.copyWith(color: AppColors.primaryColor),
              ),
              Text(
                'HUB',
                style:
                    TextStyles.bold23.copyWith(color: AppColors.secondaryColor),
              ),
            ],
          ),
        ),
        PageViewItem(
          isVisible: false,
          image: Assets.imagesPageViewItem2Image,
          backgroundImage: Assets.imagesPageViewItem2BackgroundImage,
          subtitle:
              'Searching for fresh fruits online, buyers can explore a wide variety of options, from exotic imports to locally grown produce. Detailed product descriptions and vibrant images help customers understand the quality and origin of each fruit.',
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Search and Buy',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
