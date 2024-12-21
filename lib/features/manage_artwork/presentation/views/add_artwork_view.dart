import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/repos/images_repo/images_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/manger/add_artwork/cubit/add_artwork_cubit.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/widgets/add_artwork_view_body.dart';
import 'package:art_gallery/features/manage_artwork/presentation/views/widgets/add_artwork_view_body_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddArtworkView extends StatelessWidget {
  const AddArtworkView(
      {super.key, this.update, this.defaultEntity, this.delete});

  static const routeName = 'add_artwork';
  final bool? update;
  final ArtworkEntity? defaultEntity;
  final bool? delete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text('ARTSHUB'),
        backgroundColor: Colors.amber[200],
      ),
      body: BlocProvider(
          create: (context) => AddArtworkCubit(
                getIt.get<ImagesRepo>(),
                getIt.get<ArtworksRepo>(),
              ),
          child: AddArtworkViewBodyBlocBuilder(
              update: update!, defaultEntity: defaultEntity, delete: delete!)),
    );
  }
}
