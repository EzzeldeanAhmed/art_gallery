import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/cart_model.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepo {
  Future<Either<Failure, CartModel>> getCart(String userId);
  Future<Either<Failure, String>> addArtworkToCart(
      {required String userId, required String artworkId});
  Future<Either<Failure, void>> removeArtworkFromCart(
      {required String userId, required String artworkId});
  Future<Either<Failure, void>> clearCart(String userId);
}
