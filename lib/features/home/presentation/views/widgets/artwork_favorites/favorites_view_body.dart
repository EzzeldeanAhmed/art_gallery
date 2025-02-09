import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_favorites/favorites_grid_view_bloc_builder.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artworks_grid_view_bloc_builder.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artworks_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoritesViewBody extends StatefulWidget {
  const FavoritesViewBody({
    super.key,
  });

  @override
  State<FavoritesViewBody> createState() => _FavoritesViewBodyState();
}

class _FavoritesViewBodyState extends State<FavoritesViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // without back button
          SliverAppBar(
            title: Center(child: const Text('Favorite Artworks')),
            pinned: true,
            snap: false,
            leading: null,
            automaticallyImplyLeading: false,
            floating: false,
            backgroundColor: Colors.white,
            actions: [],
          ),
          ArtworksGridViewFavBlocBuilder()
        ],
      ),
    );
  }
}
