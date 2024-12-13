import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/features/on_boarding/presentation/views/widgets/page_view_item.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/core/utils/app_colors.dart';

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
          //image: Assets.imagesPageViewItem1Image,
          image: Assets.imagesVanGoghVincent,
          backgroundImage: Assets.imagesPageViewItem1BackgroundImage,
          subtitle:
              "Explore artworks, learn about artists, and discover exhibitions and collections worldwide",
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome To ',
                style: TextStyles.bold23,
              ),
              Text(
                'ARTS',
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
          image: Assets.imagesOnbaord2trial,
          backgroundImage: Assets.imagesPageViewItem2BackgroundImage,
          subtitle:
              'Embark on a Journey Through Stunning Art Exhibitions, Explore Iconic Displays and Emerging Talent',
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Explore and Search for Artworks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
