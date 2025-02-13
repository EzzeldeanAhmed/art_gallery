import 'package:art_gallery/constants.dart';
import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/widgets/artwork_item.dart';
import 'package:art_gallery/core/widgets/search_text_field.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artist_widgets/artist_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artworks_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/exhibtion_widgets/exhibition_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/featured_item.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  // void initState() {
  //   context.read<ArtworksCubit>().getArtworks();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  height: 4,
                ),
                //SearchTextField(),
                SizedBox(
                  height: 12,
                ),
                FeaturedItem(
                  title: 'Where every piece tells unique story.',
                  subtitle: 'Artworks',
                  image: Assets.imagesArttwork,
                  onPressed: () {
                    Navigator.pushNamed(context, ArtworksView.routeName);
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                FeaturedItem(
                  title: 'Celebrating the creators who bring art to life.',
                  subtitle: 'Artists',
                  image: Assets.imagesArtist,
                  onPressed: () {
                    Navigator.pushNamed(context, ArtistView.routeName);
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                FeaturedItem(
                  title: 'Bring stories to life by art and expression.',
                  subtitle: 'Exhibitions',
                  image: Assets.imagesExhibition,
                  onPressed: () {
                    Navigator.pushNamed(context, ExhibitionsView.routeName);
                  },
                ),
                SizedBox(
                  height: 12,
                ),

                FeaturedItem(
                  title: 'Where art comes in a perfect harmony.',
                  subtitle: 'Collections',
                  image: Assets.imagesCollection,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
