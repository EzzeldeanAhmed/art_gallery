import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:art_gallery/core/repos/artist_repo/artist_repo.dart';
import 'package:art_gallery/core/repos/exhibtion_repo/exhibition_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:art_gallery/core/repos/images_repo/images_repo.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'add_exhibition_state.dart';

class AddExhibitionCubit extends Cubit<AddExhibitionState> {
  AddExhibitionCubit(this.imagesRepo, this.exhibitionsRepo)
      : super(AddExhibitionInitial());

  final ImagesRepo imagesRepo;
  final ExhibitionRepo exhibitionsRepo;
  Future<void> addExhibition(ExhibitionEntity addExhibitionInputEntity) async {
    emit(AddExhibitionLoading());
    var result = await imagesRepo.UploadImage(addExhibitionInputEntity.image!);
    result.fold(
      (f) {
        emit(
          AddExhibitionFailure(errMessage: f.message),
        );
      },
      (url) async {
        addExhibitionInputEntity.imageUrl = url;
        var result =
            await exhibitionsRepo.addExhibition(addExhibitionInputEntity);

        result.fold(
          (f) {
            emit(
              AddExhibitionFailure(errMessage: f.message),
            );
          },
          (r) {
            emit(AddExhibitionSuccess());
          },
        );
      },
    );
  }

  Future<void> updateExhibition(
      ExhibitionEntity updateExhibitionInputEntity) async {
    if (updateExhibitionInputEntity.imageUrl != null) {
      emit(AddExhibitionLoading());
      var result =
          await exhibitionsRepo.updateExhibition(updateExhibitionInputEntity);
      result.fold(
        (f) {
          emit(
            AddExhibitionFailure(errMessage: f.message),
          );
        },
        (r) {
          emit(AddExhibitionSuccess());
        },
      );
    } else {
      var result =
          await imagesRepo.UploadImage(updateExhibitionInputEntity.image!);
      result.fold(
        (f) {
          emit(
            AddExhibitionFailure(errMessage: f.message),
          );
        },
        (url) async {
          updateExhibitionInputEntity.imageUrl = url;
          var result = await exhibitionsRepo
              .updateExhibition(updateExhibitionInputEntity);

          result.fold(
            (f) {
              emit(
                AddExhibitionFailure(errMessage: f.message),
              );
            },
            (r) {
              emit(AddExhibitionSuccess());
            },
          );
        },
      );
    }
  }

  Future<void> deleteExhibition(String docuementId) async {
    emit(AddExhibitionLoading());
    var result = await exhibitionsRepo.deleteExhibition(docuementId);
    result.fold(
      (f) {
        emit(
          AddExhibitionFailure(errMessage: f.message),
        );
      },
      (r) {
        emit(AddExhibitionSuccess());
      },
    );
  }
}
