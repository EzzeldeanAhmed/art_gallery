import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/models/artwork_model.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/services/data_service.dart';
import 'package:art_gallery/core/utils/backend_endpoint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ArtworksRepoImpl extends ArtworksRepo {
  final DatabaseService databaseService;

  ArtworksRepoImpl(this.databaseService);
  @override
  Future<Either<Failure, List<ArtworkEntity>>> getArtworks() async {
    try {
      var data = await databaseService.getData(
          path: BackendEndpoint.getArtworks) as List<Map<String, dynamic>>;

      List<ArtworkEntity> artworks =
          data.map((e) => ArtworkModel.fromJson(e).toEntity()).toList();
      return right(artworks);
    } catch (e) {
      return Left(ServerFailure('Failed to get artworks'));
    }
  }

  @override
  Future<Either<Failure, List<ArtworkEntity>>> getMainArtworks(
      {String? type}) async {
    try {
      var data = await databaseService.getData(
          path: BackendEndpoint.getArtworks) as List<Map<String, dynamic>>;

      List<ArtworkEntity> artworks = data
          .where((e) {
            var artwork = ArtworkModel.fromJson(e).toEntity();
            if (artwork.status == 'borrowed' && artwork.returnDate != null) {
              if (artwork.returnDate!.isBefore(DateTime.now())) {
                artwork.status = 'other';
                artwork.returnDate = null;
                artwork.borrowDate = null;
                updateArtwork(artwork);
              }
            }
            if (artwork.status != 'other') {
              if (type == null || artwork.type == type) {
                return true;
              } else {
                return false;
              }
            }
            return false;
          })
          .map((e) => ArtworkModel.fromJson(e).toEntity())
          .toList();
      return right(artworks);
    } catch (e) {
      return Left(ServerFailure('Failed to get artworks'));
    }
  }

  @override
  Future<Either<Failure, List<ArtworkEntity>>> getOtherArtworks() async {
    try {
      var data = await databaseService.getData(
          path: BackendEndpoint.getArtworks) as List<Map<String, dynamic>>;

      List<ArtworkEntity> artworks = data
          .where((e) {
            var artwork = ArtworkModel.fromJson(e).toEntity();
            if (artwork.status == 'borrowed' && artwork.returnDate != null) {
              if (artwork.returnDate!.isBefore(DateTime.now())) {
                artwork.status = 'other';
                artwork.returnDate = null;
                artwork.borrowDate = null;
                updateArtwork(artwork);
              }
            }
            if (artwork.status == 'other' || artwork.status == 'borrowed') {
              return true;
            }
            return false;
          })
          .map((e) => ArtworkModel.fromJson(e).toEntity())
          .toList();
      return right(artworks);
    } catch (e) {
      return Left(ServerFailure('Failed to get artworks'));
    }
  }

  @override
  Future<Either<Failure, void>> addArtwork(
      ArtworkEntity addArtworkInputEntity) async {
    try {
      await databaseService.addData(
        path: BackendEndpoint.artworksCollection,
        data: ArtworkModel.fromEntity(addArtworkInputEntity).toJson(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to add Artwork'));
    }
  }

  @override
  Future<Either<Failure, void>> updateArtwork(
      ArtworkEntity updateArtworkInputEntity) async {
    try {
      await databaseService.addData(
          path: BackendEndpoint.artworksCollection,
          data: ArtworkModel.fromEntity(updateArtworkInputEntity).toJson(),
          documentId: updateArtworkInputEntity.id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to update Artwork'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteArtwork(String documentId) async {
    try {
      await databaseService.deleteData(
          path: BackendEndpoint.artworksCollection, documentId: documentId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to delete Artwork'));
    }
  }

  @override
  Future<Either<Failure, ArtworkEntity>> getArtworkById(String id) async {
    try {
      var data = await databaseService.getData(
        path: BackendEndpoint.artworksCollection,
        docuementId: id,
      ) as Map<String, dynamic>;
      data = data..addAll({'id': id});
      ArtworkEntity artwork = ArtworkModel.fromJson(data).toEntity();
      return right(artwork);
    } catch (e) {
      return Left(ServerFailure('Failed to get artworks'));
    }
  }

  @override
  Future<Either<Failure, void>> changeArtworkAttribute() async {
    try {
      var data =
          await databaseService.getData(path: BackendEndpoint.getArtworks);
      var currentArtworks = data as List<Map<String, dynamic>>;
      List<ArtworkEntity> artworks = currentArtworks
          .map((e) => ArtworkModel.fromJson(e).toEntity())
          .toList();
      for (var artwork in artworks) {
        await updateArtwork(artwork);
      }
      debugPrint(' Artwork attribute changed');
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to change Artwork attribute'));
    }
  }

  @override
  Future<Either<Failure, void>> borrowArtwork(
      ArtworkEntity artwork, DateTime returnDate) async {
    try {
      await databaseService.addData(
        path: BackendEndpoint.artworksCollection,
        data: ArtworkModel.fromEntity(artwork).toJson(),
        documentId: artwork.id,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to borrow Artwork'));
    }
  }

  @override
  Future<Either<Failure, List<ArtworkEntity>>> getArtworksByIds(
      {required List<String> ids}) async {
    try {
      var data = await databaseService
          .getData(path: BackendEndpoint.getArtworks, query: {
        'where': {'attribute': FieldPath.documentId, 'in': ids}
      }) as List<Map<String, dynamic>>;
      List<ArtworkEntity> artworks =
          data.map((e) => ArtworkModel.fromJson(e).toEntity()).toList();

      return right(artworks);
    } catch (e) {
      return Left(ServerFailure('Failed to get artworks'));
    }
  }
}
