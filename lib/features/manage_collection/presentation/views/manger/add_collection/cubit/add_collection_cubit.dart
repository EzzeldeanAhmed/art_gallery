import 'package:art_gallery/core/models/collection_entity.dart';
import 'package:art_gallery/core/repos/collection_repo/collection_repo.dart';
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

part 'add_collection_state.dart';

class AddCollectionCubit extends Cubit<AddCollectionState> {
  AddCollectionCubit(this.collectionsRepo) : super(AddCollectionInitial());
  final CollectionsRepo collectionsRepo;
  Future<void> addCollection(CollectionEntity addCollectionInputEntity) async {
    var result = await collectionsRepo.addCollection(addCollectionInputEntity);
    result.fold(
      (f) {
        emit(
          AddCollectionFailure(errMessage: f.message),
        );
      },
      (r) {
        emit(AddCollectionSuccess());
      },
    );
  }

  Future<void> updateCollection(
      CollectionEntity updateCollectionInputEntity) async {
    emit(AddCollectionLoading());
    var result =
        await collectionsRepo.updateCollection(updateCollectionInputEntity);
    result.fold(
      (f) {
        emit(
          AddCollectionFailure(errMessage: f.message),
        );
      },
      (r) {
        emit(AddCollectionSuccess());
      },
    );
  }

  Future<void> deleteCollection(String docuementId) async {
    emit(AddCollectionLoading());
    var result = await collectionsRepo.deleteCollection(docuementId);
    result.fold(
      (f) {
        emit(
          AddCollectionFailure(errMessage: f.message),
        );
      },
      (r) {
        emit(AddCollectionSuccess());
      },
    );
  }
}
