import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/core/widgets/custom_error_widget.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artworks_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ArtworksGridViewBlocBuilder extends StatelessWidget {
  const ArtworksGridViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtworksCubit, ArtworksState>(builder: (context, state) {
      if (state is ArtworksSuccess) {
        return ArtworksGridView(
          artworks: state.artworks,
        );
      } else if (state is ArtworksFailure) {
        return SliverToBoxAdapter(
            child: CustomErrorWidget(text: state.errMessage));
      } else {
        return Skeletonizer.sliver(
            enabled: true,
            child: const ArtworksGridView(
              artworks: [],
            ));
      }
    });
  }
}
