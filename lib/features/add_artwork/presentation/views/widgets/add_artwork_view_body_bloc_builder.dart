import 'package:art_gallery/core/helper_functions/build_error_bar.dart';
import 'package:art_gallery/core/widgets/custom_progress_hud.dart';
import 'package:art_gallery/features/add_artwork/presentation/views/manger/add_artwork/cubit/add_artwork_cubit.dart';
import 'package:art_gallery/features/add_artwork/presentation/views/widgets/add_artwork_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddArtworkViewBodyBlocBuilder extends StatelessWidget {
  const AddArtworkViewBodyBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddArtworkCubit, AddArtworkState>(
      listener: (context, state) {
        if (state is AddArtworkSuccess) {
          buildErrorBar(context, 'Artwork added successfully');
        }
        if (state is AddArtworkFailure) {
          buildErrorBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is AddArtworkLoading,
          child: const AddArtworkViewBody(),
        );
      },
    );
  }
}
