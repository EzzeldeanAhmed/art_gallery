import 'package:art_gallery/core/artist_cubit/artists_cubit.dart';
import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artist_widgets/artists_grid_view_bloc_builder.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artist_widgets/artists_search_page.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artworks_grid_view_bloc_builder.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artworks_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ArtistsViewBody extends StatefulWidget {
  const ArtistsViewBody({
    super.key,
  });

  @override
  State<ArtistsViewBody> createState() => _ArtistsViewBodyState();
}

class _ArtistsViewBodyState extends State<ArtistsViewBody> {
  void initState() {
    context.read<ArtistsCubit>().getArtists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Artists'),
            pinned: true,
            snap: false,
            floating: false,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            actions: [
              IconButton(
                  padding: EdgeInsets.only(right: 20),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ArtistsSearchPage()));
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          ArtistsGridViewBlocBuilder()
        ],
      ),
    );
  }
}
