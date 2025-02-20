import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/artist_model.dart';
import 'package:art_gallery/core/models/cart_entity.dart';
import 'package:art_gallery/core/models/cart_model.dart';
import 'package:art_gallery/core/repos/artist_repo/artist_repo.dart';
import 'package:art_gallery/core/repos/cart_repo/cart_repo.dart';
import 'package:art_gallery/core/services/data_service.dart';
import 'package:art_gallery/core/utils/backend_endpoint.dart';
import 'package:dartz/dartz.dart';

class CartRepoImpl extends CartRepo {
  final DatabaseService databaseService;

  CartRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, String>> addArtworkToCart(
      {required String userId, required String artworkId}) async {
    CartModel cart;
    try {
      var data = await databaseService.getDataWhere(
          path: BackendEndpoint.getCart,
          attribute: "userID",
          value: userId) as List<Map<String, dynamic>>;
      ;
      List<CartModel> carts = data.map((e) => CartModel.fromJson(e)).toList();
      cart = carts.first;
    } catch (e) {
      cart = CartModel(userID: userId, artworksID: []);
    }
    if (cart.artworksID.contains(artworkId)) {
      return Future.value(right("already in cart!"));
    }
    try {
      cart.artworksID.add(artworkId);
      if (cart.id == null) {
        await databaseService.addData(
          path: BackendEndpoint.getCart,
          data: cart.toJson(),
        );
      } else {
        databaseService.addData(
          path: BackendEndpoint.getCart,
          data: cart.toJson(),
          documentId: cart.id,
        );
      }
      return Future.value(right("added to cart!"));
    } catch (e) {
      return Future.value(left(ServerFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart(String userId) {
    // TODO: implement clearCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CartModel>> getCart(String userId) async {
    try {
      var data = await databaseService.getDataWhere(
          path: BackendEndpoint.getCart,
          attribute: "userID",
          value: userId) as List<Map<String, dynamic>>;
      ;
      List<CartModel> carts = data.map((e) => CartModel.fromJson(e)).toList();
      return Future.value(right(carts.first));
    } catch (e) {
      try {
        CartModel cart = CartModel(userID: userId, artworksID: []);
        await databaseService.addData(
          path: BackendEndpoint.getCart,
          data: cart.toJson(),
        );
        var data = await databaseService.getDataWhere(
            path: BackendEndpoint.getCart,
            attribute: "userID",
            value: userId) as List<Map<String, dynamic>>;
        ;
        var carts = data.map((e) => CartModel.fromJson(e)).toList();
        return Future.value(right(carts.first));
      } catch (e) {
        return Future.value(left(ServerFailure(e.toString())));
      }
    }
  }

  @override
  Future<Either<Failure, void>> removeArtworkFromCart(
      {required String userId, required String artworkId}) {
    // TODO: implement removeArtworkFromCart
    throw UnimplementedError();
  }
}
