import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/collection_entity.dart';
import 'package:art_gallery/core/models/collection_model.dart';
import 'package:art_gallery/core/repos/collection_repo/collection_repo.dart';
import 'package:art_gallery/core/services/data_service.dart';
import 'package:art_gallery/core/utils/backend_endpoint.dart';
import 'package:dartz/dartz.dart';

class CollectionRepoImpl extends CollectionsRepo {
  final DatabaseService databaseService;

  CollectionRepoImpl(this.databaseService);
  @override
  Future<Either<Failure, List<CollectionEntity>>> getCollections() async {
    try {
      var data = await databaseService.getData(
          path: BackendEndpoint.getCollections) as List<Map<String, dynamic>>;

      List<CollectionEntity> collections =
          data.map((e) => CollectionModel.fromJson(e).toEntity()).toList();
      return right(collections);
    } catch (e) {
      return Left(ServerFailure('Failed to get collections'));
    }
  }

  @override
  Future<Either<Failure, void>> addCollection(
      CollectionEntity addCollectionInputEntity) async {
    try {
      await databaseService.addData(
        path: BackendEndpoint.collectionsCollection,
        data: CollectionModel.fromEntity(addCollectionInputEntity).toJson(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to add Collection'));
    }
  }

  @override
  Future<Either<Failure, void>> updateCollection(
      CollectionEntity updateCollectionInputEntity) async {
    try {
      await databaseService.addData(
          path: BackendEndpoint.collectionsCollection,
          data:
              CollectionModel.fromEntity(updateCollectionInputEntity).toJson(),
          documentId: updateCollectionInputEntity.id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to update Collection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCollection(String documentId) async {
    try {
      await databaseService.deleteData(
          path: BackendEndpoint.collectionsCollection, documentId: documentId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to delete Collection'));
    }
  }
}
