import 'package:art_gallery/core/artwork_cubit/artworks_cubit.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/artwork_favorites/favorites_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesView extends StatelessWidget {
  FavoritesView({super.key, this.profile = false});
  static const routeName = 'favorites_artworks_view';
  bool profile = false;
  @override
  Widget build(BuildContext context) {
    return FavoritesViewBody(
      profile: profile,
    );
  }
}
