import 'package:art_gallery/constants.dart';
import 'package:art_gallery/core/artist_cubit/artists_cubit.dart';
import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/core/repos/artist_repo/artist_repo.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artist_widgets/artist_view_body.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artworks_grid_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artworks_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistView extends StatelessWidget {
  const ArtistView({super.key});
  static const routeName = 'artists_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArtistsCubit(
        getIt.get<ArtistsRepo>(),
      ),
      child: const ArtistsViewBody(),
    );
  }
}
