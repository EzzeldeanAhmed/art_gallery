import 'package:art_gallery/core/helper_functions/build_error_bar.dart';
import 'package:art_gallery/core/models/collection_entity.dart';
import 'package:art_gallery/core/widgets/custom_progress_hud.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/manger/add_collection/cubit/add_collection_cubit.dart';
import 'package:art_gallery/features/manage_collection/presentation/views/widgets/add_collection_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCollectionViewBodyBlocBuilder extends StatelessWidget {
  const AddCollectionViewBodyBlocBuilder(
      {super.key, this.update, this.defaultEntity, this.delete});

  final bool? update;
  final CollectionEntity? defaultEntity;
  final bool? delete;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCollectionCubit, AddCollectionState>(
      listener: (context, state) {
        if (state is AddCollectionSuccess) {
          if (delete!) {
            buildErrorBar(context, 'Collection deleted successfully');
          } else if (update!) {
            buildErrorBar(context, 'Collection updated successfully');
          } else {
            buildErrorBar(context, 'Collection added successfully');
          }
        }
        if (state is AddCollectionFailure) {
          buildErrorBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is AddCollectionLoading,
          child: AddCollectionViewBody(
              update: update, defaultEntity: defaultEntity, delete: delete),
        );
      },
    );
  }
}
