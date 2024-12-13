import 'package:art_gallery/constants.dart';
import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artworks_grid_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artworks_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtworksView extends StatelessWidget {
  const ArtworksView({super.key});
  static const routeName = 'artworks_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArtworksCubit(
        getIt.get<ArtworksRepo>(),
      ),
      child: const ArtworksViewBody(),
    );
  }
}
