import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/artist_model.dart';
import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:art_gallery/core/models/exhibition_model.dart';
import 'package:art_gallery/core/repos/artist_repo/artist_repo.dart';
import 'package:art_gallery/core/repos/exhibtion_repo/exhibition_repo.dart';
import 'package:art_gallery/core/services/data_service.dart';
import 'package:art_gallery/core/utils/backend_endpoint.dart';
import 'package:dartz/dartz.dart';

class ExhibitionRepoImpl extends ExhibitionRepo {
  final DatabaseService databaseService;

  ExhibitionRepoImpl(this.databaseService);
  @override
  Future<Either<Failure, List<ExhibitionEntity>>> getExhibitions() async {
    try {
      var data = await databaseService.getData(
          path: BackendEndpoint.getExhibitions) as List<Map<String, dynamic>>;

      List<ExhibitionEntity> exhibitions =
          data.map((e) => ExhibitionModel.fromJson(e).toEntity()).toList();
      return right(exhibitions);
    } catch (e) {
      return Left(ServerFailure('Failed to get exhibitions'));
    }
  }

  @override
  Future<Either<Failure, void>> addExhibition(
      ExhibitionEntity addExhibitionInputEntity) async {
    try {
      await databaseService.addData(
        path: BackendEndpoint.exhibitionsCollection,
        data: ExhibitionModel.fromEntity(addExhibitionInputEntity).toJson(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to add Exhibition'));
    }
  }

  @override
  Future<Either<Failure, void>> updateExhibition(
      ExhibitionEntity updateExhibitionInputEntity) async {
    try {
      await databaseService.addData(
          path: BackendEndpoint.exhibitionsCollection,
          data:
              ExhibitionModel.fromEntity(updateExhibitionInputEntity).toJson(),
          documentId: updateExhibitionInputEntity.id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to update Exhibition'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExhibition(String documentId) async {
    try {
      await databaseService.deleteData(
          path: BackendEndpoint.exhibitionsCollection, documentId: documentId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to delete Exhibition'));
    }
  }

  @override
  Future<Either<Failure, ExhibitionEntity>> getExhibition(String name) async {
    var data = databaseService.getDataWhere(
        path: BackendEndpoint.getExhibitions,
        attribute: "name",
        value: name) as List<Map<String, dynamic>>;
    ;
    List<ExhibitionEntity> exhibitions =
        data.map((e) => ExhibitionModel.fromJson(e).toEntity()).toList();
    return right(exhibitions[0]);
  }
}
