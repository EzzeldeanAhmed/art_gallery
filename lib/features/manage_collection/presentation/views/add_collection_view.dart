import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/collection_entity.dart';
import 'package:art_gallery/core/repos/collection_repo/collection_repo.dart';
import 'package:art_gallery/core/repos/artist_repo/artist_repo.dart';
import 'package:art_gallery/core/repos/images_repo/images_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/manger/add_artist/cubit/add_artist_cubit.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/widgets/add_artist_view_body.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/widgets/add_artist_view_body_bloc_builder.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/manger/add_collection/cubit/add_collection_cubit.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/widgets/add_collection_view_body_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCollectionView extends StatelessWidget {
  const AddCollectionView(
      {super.key, this.update, this.defaultEntity, this.delete});

  static const routeName = 'add_artist';
  final bool? update;
  final CollectionEntity? defaultEntity;
  final bool? delete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text('Art Musuem Gallery'),
        // backgroundColor: Colors.amber[200],
      ),
      body: BlocProvider(
          create: (context) => AddCollectionCubit(
                getIt.get<CollectionsRepo>(),
              ),
          child: AddCollectionViewBodyBlocBuilder(
              update: update!, defaultEntity: defaultEntity, delete: delete!)),
    );
  }
}
