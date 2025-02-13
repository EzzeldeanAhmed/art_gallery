import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ExhibitionRepo {
  Future<Either<Failure, List<ExhibitionEntity>>> getExhibitions();
  Future<Either<Failure, List<ExhibitionEntity>>> getExhibitionsFilter(
      String filter);

  Future<Either<Failure, ExhibitionEntity>> getExhibition(String name);
  Future<Either<Failure, void>> addExhibition(
      ExhibitionEntity addExhibitionInputEntity);
  Future<Either<Failure, void>> updateExhibition(
      ExhibitionEntity updateExhibitionEntity);
  Future<Either<Failure, void>> deleteExhibition(String documentId);
}
