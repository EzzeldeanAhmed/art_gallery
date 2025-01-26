import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/repos/artist_repo/artist_repo.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'artists_state.dart';

class ArtistsCubit extends Cubit<ArtistsState> {
  ArtistsCubit(this.artistsRepo) : super(ArtistsInitial());

  final ArtistsRepo artistsRepo;
  Future<void> getArtists() async {
    emit(ArtistsLoading());
    final result = await artistsRepo.getArtists();
    result.fold(
      (failure) => emit(ArtistsFailure(failure.message)),
      (artists) => emit(ArtistsSuccess(artists)),
    );
  }
}
