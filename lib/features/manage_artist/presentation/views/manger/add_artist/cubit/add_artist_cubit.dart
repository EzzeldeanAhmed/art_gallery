import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/repos/artist_repo/artist_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:art_gallery/core/repos/images_repo/images_repo.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'add_artist_state.dart';

class AddArtistCubit extends Cubit<AddArtistState> {
  AddArtistCubit(this.imagesRepo, this.artistsRepo) : super(AddArtistInitial());

  final ImagesRepo imagesRepo;
  final ArtistRepo artistsRepo;
  Future<void> addArtist(ArtistEntity addArtistInputEntity) async {
    emit(AddArtistLoading());
    var result = await imagesRepo.UploadImage(addArtistInputEntity.image!);
    result.fold(
      (f) {
        emit(
          AddArtistFailure(errMessage: f.message),
        );
      },
      (url) async {
        addArtistInputEntity.imageUrl = url;
        var result = await artistsRepo.addArtist(addArtistInputEntity);

        result.fold(
          (f) {
            emit(
              AddArtistFailure(errMessage: f.message),
            );
          },
          (r) {
            emit(AddArtistSuccess());
          },
        );
      },
    );
  }

  Future<void> updateArtist(ArtistEntity updateArtistInputEntity) async {
    if (updateArtistInputEntity.imageUrl != null) {
      emit(AddArtistLoading());
      var result = await artistsRepo.updateArtist(updateArtistInputEntity);
      result.fold(
        (f) {
          emit(
            AddArtistFailure(errMessage: f.message),
          );
        },
        (r) {
          emit(AddArtistSuccess());
        },
      );
    } else {
      var result = await imagesRepo.UploadImage(updateArtistInputEntity.image!);
      result.fold(
        (f) {
          emit(
            AddArtistFailure(errMessage: f.message),
          );
        },
        (url) async {
          updateArtistInputEntity.imageUrl = url;
          var result = await artistsRepo.updateArtist(updateArtistInputEntity);

          result.fold(
            (f) {
              emit(
                AddArtistFailure(errMessage: f.message),
              );
            },
            (r) {
              emit(AddArtistSuccess());
            },
          );
        },
      );
    }
  }

  Future<void> deleteArtist(String docuementId) async {
    emit(AddArtistLoading());
    var result = await artistsRepo.deleteArtist(docuementId);
    result.fold(
      (f) {
        emit(
          AddArtistFailure(errMessage: f.message),
        );
      },
      (r) {
        emit(AddArtistSuccess());
      },
    );
  }
}
