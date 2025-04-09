import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/artist_model.dart';
import 'package:art_gallery/core/models/payment_entity.dart';
import 'package:art_gallery/core/models/payment_model.dart';
import 'package:art_gallery/core/repos/artist_repo/artist_repo.dart';
import 'package:art_gallery/core/repos/payment_repo/payment_repo.dart';
import 'package:art_gallery/core/services/data_service.dart';
import 'package:art_gallery/core/utils/backend_endpoint.dart';
import 'package:dartz/dartz.dart';

class PaymentRepoImpl extends PaymentsRepo {
  final DatabaseService databaseService;

  PaymentRepoImpl(this.databaseService);
  @override
  Future<Either<Failure, List<PaymentEntity>>> getPayments() async {
    try {
      var data = await databaseService.getData(
          path: BackendEndpoint.getPayments) as List<Map<String, dynamic>>;

      List<PaymentEntity> payments =
          data.map((e) => PaymentModel.fromJson(e).toEntity()).toList();
      return right(payments);
    } catch (e) {
      return Left(ServerFailure('Failed to get payments'));
    }
  }

  @override
  Future<Either<Failure, void>> addPayment(
      PaymentEntity addPaymentInputEntity) async {
    try {
      await databaseService.addData(
        path: BackendEndpoint.paymentsCollection,
        data: PaymentModel.fromEntity(addPaymentInputEntity).toJson(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to add Payment'));
    }
  }

  @override
  Future<Either<Failure, void>> updatePayment(
      PaymentEntity updatePaymentInputEntity) async {
    try {
      await databaseService.addData(
          path: BackendEndpoint.paymentsCollection,
          data: PaymentModel.fromEntity(updatePaymentInputEntity).toJson(),
          documentId: updatePaymentInputEntity.id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to update Payment'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePayment(String documentId) async {
    try {
      await databaseService.deleteData(
          path: BackendEndpoint.paymentsCollection, documentId: documentId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to delete Payment'));
    }
  }

  @override
  Future<Either<Failure, PaymentEntity>> getPayment(String name) async {
    var data = databaseService.getDataWhere(
        path: BackendEndpoint.getPayments,
        attribute: "name",
        value: name) as List<Map<String, dynamic>>;
    ;
    List<PaymentEntity> payments =
        data.map((e) => PaymentModel.fromJson(e).toEntity()).toList();
    return right(payments[0]);
  }

  @override
  Future<Either<Failure, List<PaymentModel>>> getPaymentsUser(
      String userId) async {
    var rawData = await databaseService.getDataWhere(
        path: BackendEndpoint.getPayments, attribute: "userId", value: userId);

    var data = rawData as List<Map<String, dynamic>>;

    List<PaymentModel> payments =
        data.map((e) => PaymentModel.fromJson(e)).toList();
    return right(payments);
  }
}
