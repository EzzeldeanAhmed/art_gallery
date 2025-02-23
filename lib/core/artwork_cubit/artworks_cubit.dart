import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'artworks_state.dart';

class ArtworksCubit extends Cubit<ArtworksState> {
  ArtworksCubit(this.artworksRepo) : super(ArtworksInitial());

  final ArtworksRepo artworksRepo;
  Future<void> getArtworks({String type = 'All'}) async {
    emit(ArtworksLoading());
    if (type == 'All') {
      final result = await artworksRepo.getMainArtworks();
      result.fold(
        (failure) => emit(ArtworksFailure(failure.message)),
        (artworks) => emit(ArtworksSuccess(artworks)),
      );
    } else {
      final result = await artworksRepo.getMainArtworks(type: type);
      result.fold(
        (failure) => emit(ArtworksFailure(failure.message)),
        (artworks) => emit(ArtworksSuccess(
            artworks.where((element) => element.type == type).toList())),
      );
    }
  }
}
