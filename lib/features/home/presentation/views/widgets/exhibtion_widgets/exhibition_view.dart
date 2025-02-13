import 'package:art_gallery/constants.dart';
import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/core/exhibition_cubit/exhibitions_cubit.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/repos/exhibtion_repo/exhibition_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artworks_grid_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artworks_view_body.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/exhibtion_widgets/exhibition_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExhibitionsView extends StatelessWidget {
  const ExhibitionsView({super.key});
  static const routeName = 'exhibitions_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExhibitionCubit(
        getIt.get<ExhibitionRepo>(),
      ),
      child: const ExhibitionsViewBody(),
    );
  }
}
