import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/artist_model.dart';
import 'package:art_gallery/core/repos/artist_repo/artist_repo.dart';
import 'package:art_gallery/core/services/data_service.dart';
import 'package:art_gallery/core/utils/backend_endpoint.dart';
import 'package:dartz/dartz.dart';

class ArtistRepoImpl extends ArtistsRepo {
  final DatabaseService databaseService;

  ArtistRepoImpl(this.databaseService);
  @override
  Future<Either<Failure, List<ArtistEntity>>> getArtists() async {
    try {
      var data = await databaseService.getData(path: BackendEndpoint.getArtists)
          as List<Map<String, dynamic>>;

      List<ArtistEntity> artists =
          data.map((e) => ArtistModel.fromJson(e).toEntity()).toList();
      return right(artists);
    } catch (e) {
      return Left(ServerFailure('Failed to get artists'));
    }
  }

  @override
  Future<Either<Failure, void>> addArtist(
      ArtistEntity addArtistInputEntity) async {
    try {
      await databaseService.addData(
        path: BackendEndpoint.artistsCollection,
        data: ArtistModel.fromEntity(addArtistInputEntity).toJson(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to add Artist'));
    }
  }

  @override
  Future<Either<Failure, void>> updateArtist(
      ArtistEntity updateArtistInputEntity) async {
    try {
      await databaseService.addData(
          path: BackendEndpoint.artistsCollection,
          data: ArtistModel.fromEntity(updateArtistInputEntity).toJson(),
          documentId: updateArtistInputEntity.id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to update Artist'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteArtist(String documentId) async {
    try {
      await databaseService.deleteData(
          path: BackendEndpoint.artistsCollection, documentId: documentId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to delete Artist'));
    }
  }
}
