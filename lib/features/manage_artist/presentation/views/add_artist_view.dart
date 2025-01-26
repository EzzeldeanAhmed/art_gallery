import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/repos/artist_repo/artist_repo.dart';
import 'package:art_gallery/core/repos/images_repo/images_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/manger/add_artist/cubit/add_artist_cubit.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/widgets/add_artist_view_body.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/widgets/add_artist_view_body_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddArtistView extends StatelessWidget {
  const AddArtistView(
      {super.key, this.update, this.defaultEntity, this.delete});

  static const routeName = 'add_artist';
  final bool? update;
  final ArtistEntity? defaultEntity;
  final bool? delete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text('Art Musuem Gallery'),
        backgroundColor: Colors.amber[200],
      ),
      body: BlocProvider(
          create: (context) => AddArtistCubit(
                getIt.get<ImagesRepo>(),
                getIt.get<ArtistsRepo>(),
              ),
          child: AddArtistViewBodyBlocBuilder(
              update: update!, defaultEntity: defaultEntity, delete: delete!)),
    );
  }
}
