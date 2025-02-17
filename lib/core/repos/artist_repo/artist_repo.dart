import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ArtistsRepo {
  Future<Either<Failure, List<ArtistEntity>>> getArtists();
  Future<Either<Failure, ArtistEntity>> getArtist(String name);
  Future<Either<Failure, void>> addArtist(ArtistEntity addArtistInputEntity);
  Future<Either<Failure, void>> updateArtist(ArtistEntity updateArtistEntity);
  Future<Either<Failure, void>> deleteArtist(String documentId);
}
