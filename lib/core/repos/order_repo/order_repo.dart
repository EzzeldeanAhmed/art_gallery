import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/order_model.dart';
import 'package:dartz/dartz.dart';

abstract class OrderRepo {
  Future<Either<Failure, List<OrderModel>>> getOrders();
  Future<Either<Failure, List<OrderModel>>> getOrdersByUserId(String userID);
  Future<Either<Failure, void>> addOrder(OrderModel addOrderInputMOrderModel);
  Future<Either<Failure, void>> updateOrder(OrderModel updateOrderModel);
  Future<Either<Failure, void>> deleteOrder(String documentId);
}
