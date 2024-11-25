import 'package:flutter/material.dart';
import 'package:art_gallery/constants.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/widgets/search_text_field.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/featured_item.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/featured_list.dart';

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
                    title: 'Where every piece tells a unique story.',
                    subtitle: 'Artworks',
                    image: Assets.imagesArttwork,
                    buttonAction: ''),
                SizedBox(
                  height: 12,
                ),
                FeaturedItem(
                    title: 'Celebrating the creators who bring art to life.',
                    subtitle: 'Artists',
                    image: Assets.imagesArtist,
                    buttonAction: ''),
                SizedBox(
                  height: 12,
                ),
                FeaturedItem(
                    title: 'Where art comes together in perfect harmony.',
                    subtitle: 'Collections',
                    image: Assets.imagesCollection,
                    buttonAction: ''),
                SizedBox(
                  height: 12,
                ),
                FeaturedItem(
                    title: 'Bring stories to life by art and expression.',
                    subtitle: 'Exhibitions',
                    image: Assets.imagesExhibition,
                    buttonAction: ''),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
