import 'package:art_gallery/constants.dart';
import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/features/home/components/categories_chip.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artworks_grid_view_bloc_builder.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artworks_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ArtworksViewBody extends StatefulWidget {
  ArtworksViewBody({
    super.key,
  });
  String type = 'All';
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
          SliverToBoxAdapter(
            child: typesChips(),
          ),
          ArtworksGridViewBlocBuilder()
        ],
      ),
    );
  }

  List<String> typeItems = [
    'All',
    'Sculpture',
    'Drawings',
    'Paintings',
    'Black and White',
    'Mosaic'
  ];

  Widget typesChips() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: List<Widget>.generate(
                typeItems.length, // place the length of the array here
                (int index) {
              return CategoriesChip(
                label: typeItems[index],
                isActive: typeItems[index] == widget.type,
                onPressed: () {
                  setState(() {
                    widget.type = typeItems[index];
                    context
                        .read<ArtworksCubit>()
                        .getArtworks(type: widget.type);
                  });
                },
              );
            }).toList(),
          ),
        ));
  }
}
