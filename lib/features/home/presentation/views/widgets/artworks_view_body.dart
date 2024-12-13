import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artworks_grid_view_bloc_builder.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artworks_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ArtworksViewBody extends StatefulWidget {
  const ArtworksViewBody({
    super.key,
  });

  @override
  State<ArtworksViewBody> createState() => _ArtworksViewBodyState();
}

class _ArtworksViewBodyState extends State<ArtworksViewBody> {
  void initState() {
    context.read<ArtworksCubit>().getArtworks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Artworks'),
            pinned: true,
            snap: false,
            floating: false,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                  padding: EdgeInsets.only(right: 20),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ArtworksSearchPage()));
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          ArtworksGridViewBlocBuilder()
        ],
      ),
    );
  }
}
