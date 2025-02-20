import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/collection_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CollectionsRepo {
  Future<Either<Failure, List<CollectionEntity>>> getCollections();
  Future<CollectionEntity> getCollectionById(String id);
  Future<Either<Failure, void>> addCollection(
      CollectionEntity addCollectionInputEntity);
  Future<Either<Failure, void>> updateCollection(
      CollectionEntity updateCollectionEntity);
  Future<Either<Failure, void>> deleteCollection(String documentId);
}
