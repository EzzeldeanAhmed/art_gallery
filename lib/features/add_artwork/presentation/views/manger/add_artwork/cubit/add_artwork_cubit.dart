import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:art_gallery/core/repos/images_repo/images_repo.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'add_artwork_state.dart';

class AddArtworkCubit extends Cubit<AddArtworkState> {
  AddArtworkCubit(this.imagesRepo, this.artworksRepo)
      : super(AddArtworkInitial());

  final ImagesRepo imagesRepo;
  final ArtworksRepo artworksRepo;
  Future<void> addArtwork(ArtworkEntity addArtworkInputEntity) async {
    emit(AddArtworkLoading());
    var result = await imagesRepo.UploadImage(addArtworkInputEntity.image!);
    result.fold(
      (f) {
        emit(
          AddArtworkFailure(errMessage: f.message),
        );
      },
      (url) async {
        addArtworkInputEntity.imageUrl = url;
        var result = await artworksRepo.addArtwork(addArtworkInputEntity);

        result.fold(
          (f) {
            emit(
              AddArtworkFailure(errMessage: f.message),
            );
          },
          (r) {
            emit(AddArtworkSuccess());
          },
        );
      },
    );
  }
}
