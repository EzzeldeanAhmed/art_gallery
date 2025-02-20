import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ArtworksRepo {
  Future<Either<Failure, List<ArtworkEntity>>> getArtworks();
  Future<Either<Failure, List<ArtworkEntity>>> getMainArtworks();
  Future<Either<Failure, List<ArtworkEntity>>> getOtherArtworks();

  Future<Either<Failure, void>> addArtwork(ArtworkEntity addArtworkInputEntity);
  Future<Either<Failure, void>> updateArtwork(
      ArtworkEntity updateArtworkEntity);
  Future<Either<Failure, void>> deleteArtwork(String documentId);
  Future<Either<Failure, void>> borrowArtwork(
      ArtworkEntity artwork, DateTime returnDate);
  Future<Either<Failure, ArtworkEntity>> getArtworkById(String id);
  Future<Either<Failure, void>> changeArtworkAttribute();
}
