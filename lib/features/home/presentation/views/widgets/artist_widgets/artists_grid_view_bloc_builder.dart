import 'package:art_gallery/core/artist_cubit/artists_cubit.dart';
import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/core/widgets/custom_error_widget.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artist_widgets/artists_grid_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artworks_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ArtistsGridViewBlocBuilder extends StatelessWidget {
  const ArtistsGridViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistsCubit, ArtistsState>(builder: (context, state) {
      if (state is ArtistsSuccess) {
        return ArtistsGridView(
          artists: state.artists,
        );
      } else if (state is ArtistsFailure) {
        return SliverToBoxAdapter(
            child: CustomErrorWidget(text: state.errMessage));
      } else {
        return Skeletonizer.sliver(
            enabled: true,
            child: const ArtistsGridView(
              artists: [],
            ));
      }
    });
  }
}
