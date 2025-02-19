import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_widgets/artworks_view.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:art_gallery/constants.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/widgets/search_text_field.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/featured_item.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/featured_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // getIt.get<ArtworksRepo>().changeArtworkAttribute();
    return const HomeViewBody();
  }
}
