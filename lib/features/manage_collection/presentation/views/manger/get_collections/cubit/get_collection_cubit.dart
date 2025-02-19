import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/collection_entity.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/repos/collection_repo/collection_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'get_collection_state.dart';

class GetCollectionCubit extends Cubit<GetCollectionState> {
  GetCollectionCubit(this.collectionsRepo, this.artworksRepo)
      : super(GetCollectionInitial());
  final CollectionsRepo collectionsRepo;
  final ArtworksRepo artworksRepo;

  Future<void> getCollectionArtworks() async {
    emit(GetCollectionLoading());
    try {
      var artworks = await artworksRepo.getArtworks();
      var collections = await collectionsRepo.getCollections();
      Map<String, Map<String, dynamic>> data = {};

      collections.fold((Failure) {
        emit(GetCollectionFailure(errMessage: 'No collections found'));
      }, (collectionsList) {
        artworks.fold((Failure) {
          emit(GetCollectionFailure(errMessage: 'No artworks found'));
        }, (artworksList) {
          for (var collection in collectionsList) {
            data[collection.id!] = {'collection': collection, 'artworks': []};
          }
          for (var artwork in artworksList) {
            if (artwork.collectionID! != "Main") {
              data[artwork.collectionID!]!['artworks'].add(artwork);
            }
          }
        });
        // iterate over map
        List<Map<String, dynamic>> dataList = [];
        data.forEach((key, value) {
          dataList.add(value);
        });
        emit(GetCollectionSuccess(dataList));
      });
    } catch (e) {
      emit(GetCollectionFailure(errMessage: e.toString()));
    }
  }
}
