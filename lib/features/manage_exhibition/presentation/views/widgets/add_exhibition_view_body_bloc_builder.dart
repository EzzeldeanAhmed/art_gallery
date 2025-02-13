import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/core/helper_functions/build_error_bar.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/widgets/custom_progress_hud.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/manger/add_artist/cubit/add_artist_cubit.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/widgets/add_artist_view_body.dart';
import 'package:art_gallery/features/manage_exhibition/presentation/views/manger/add_artist/cubit/add_exhibition_cubit.dart';
import 'package:art_gallery/features/manage_exhibition/presentation/views/widgets/add_exhibition_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExhibitionViewBodyBlocBuilder extends StatelessWidget {
  const AddExhibitionViewBodyBlocBuilder(
      {super.key, this.update, this.defaultEntity, this.delete});

  final bool? update;
  final ExhibitionEntity? defaultEntity;
  final bool? delete;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddExhibitionCubit, AddExhibitionState>(
      listener: (context, state) {
        if (state is AddExhibitionSuccess) {
          if (delete!) {
            buildErrorBar(context, 'Exhibition deleted successfully');
          } else if (update!) {
            buildErrorBar(context, 'Exhibition updated successfully');
          } else {
            buildErrorBar(context, 'Exhibition added successfully');
          }
        }
        if (state is AddExhibitionFailure) {
          buildErrorBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return BlocProvider(
            create: (context) => ArtworksCubit(
                  getIt.get<ArtworksRepo>(),
                ),
            child: CustomProgressHud(
              isLoading: state is AddExhibitionLoading,
              child: AddExhibitionViewBody(
                  update: update, defaultEntity: defaultEntity, delete: delete),
            ));
      },
    );
  }
}
