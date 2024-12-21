import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ArtworksRepo {
  Future<Either<Failure, List<ArtworkEntity>>> getArtworks();
  Future<Either<Failure, void>> addArtwork(ArtworkEntity addArtworkInputEntity);
  Future<Either<Failure, void>> updateArtwork(
      ArtworkEntity updateArtworkEntity);
}
