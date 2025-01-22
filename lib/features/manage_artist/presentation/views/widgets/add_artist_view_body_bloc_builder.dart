import 'package:art_gallery/core/helper_functions/build_error_bar.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/widgets/custom_progress_hud.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/manger/add_artist/cubit/add_artist_cubit.dart';
import 'package:art_gallery/features/manage_artist/presentation/views/widgets/add_artist_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddArtistViewBodyBlocBuilder extends StatelessWidget {
  const AddArtistViewBodyBlocBuilder(
      {super.key, this.update, this.defaultEntity, this.delete});

  final bool? update;
  final ArtistEntity? defaultEntity;
  final bool? delete;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddArtistCubit, AddArtistState>(
      listener: (context, state) {
        if (state is AddArtistSuccess) {
          if (delete!) {
            buildErrorBar(context, 'Artist deleted successfully');
          } else if (update!) {
            buildErrorBar(context, 'Artist updated successfully');
          } else {
            buildErrorBar(context, 'Artist added successfully');
          }
        }
        if (state is AddArtistFailure) {
          buildErrorBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is AddArtistLoading,
          child: AddArtistViewBody(
              update: update, defaultEntity: defaultEntity, delete: delete),
        );
      },
    );
  }
}
