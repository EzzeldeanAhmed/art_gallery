import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/artist_model.dart';
import 'package:art_gallery/core/models/order_model.dart';
import 'package:art_gallery/core/repos/artist_repo/artist_repo.dart';
import 'package:art_gallery/core/repos/order_repo/order_repo.dart';
import 'package:art_gallery/core/services/data_service.dart';
import 'package:art_gallery/core/utils/backend_endpoint.dart';
import 'package:dartz/dartz.dart';

class OrderRepoImpl extends OrderRepo {
  final DatabaseService databaseService;

  OrderRepoImpl(this.databaseService);
  @override
  Future<Either<Failure, List<OrderModel>>> getOrders() async {
    try {
      var data = await databaseService.getData(path: BackendEndpoint.getOrders)
          as List<Map<String, dynamic>>;

      List<OrderModel> orders =
          data.map((e) => OrderModel.fromJson(e)).toList();
      return right(orders);
    } catch (e) {
      return Left(ServerFailure('Failed to get orders'));
    }
  }

  @override
  Future<Either<Failure, void>> addOrder(OrderModel addOrderInputModel) async {
    try {
      await databaseService.addData(
        path: BackendEndpoint.ordersCollection,
        data: addOrderInputModel.toJson(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to add Order'));
    }
  }

  @override
  Future<Either<Failure, void>> updateOrder(
      OrderModel updateOrderInputModel) async {
    try {
      await databaseService.addData(
          path: BackendEndpoint.ordersCollection,
          data: updateOrderInputModel.toJson(),
          documentId: updateOrderInputModel.id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to update Order'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrder(String documentId) async {
    try {
      await databaseService.deleteData(
          path: BackendEndpoint.ordersCollection, documentId: documentId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to delete Order'));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getOrdersByUserId(
      String userId) async {
    var data = databaseService.getDataWhere(
        path: BackendEndpoint.getOrders,
        attribute: "userID",
        value: userId) as List<Map<String, dynamic>>;
    List<OrderModel> orders = data.map((e) => OrderModel.fromJson(e)).toList();
    return right(orders);
  }
}
