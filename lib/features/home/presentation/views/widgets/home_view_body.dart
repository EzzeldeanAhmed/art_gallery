import 'package:flutter/material.dart';
import 'package:fruits_hub/constants.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/core/widgets/search_text_field.dart';
import 'package:fruits_hub/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:fruits_hub/features/home/presentation/views/widgets/featured_item.dart';
import 'package:fruits_hub/features/home/presentation/views/widgets/featured_list.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: kTopPaddding,
                ),
                CustomHomeAppBar(),
                SizedBox(
                  height: 16,
                ),
                SearchTextField(),
                SizedBox(
                  height: 12,
                ),
                FeaturedItem(
                    title: 'Fresh Fruits',
                    subtitle: 'ay 7aga',
                    image: Assets.imagesArt2,
                    buttonAction: ''),
                SizedBox(
                  height: 12,
                ),
                FeaturedItem(
                    title: 'Fresh Fruits',
                    subtitle: 'ay 7aga',
                    image: Assets.imagesArt2,
                    buttonAction: ''),
                SizedBox(
                  height: 12,
                ),
                FeaturedItem(
                    title: 'Fresh Fruits',
                    subtitle: 'ay 7aga',
                    image: Assets.imagesArt2,
                    buttonAction: ''),
                SizedBox(
                  height: 12,
                ),
                FeaturedItem(
                    title: 'Fresh Fruits',
                    subtitle: 'ay 7aga',
                    image: Assets.imagesArt2,
                    buttonAction: ''),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
