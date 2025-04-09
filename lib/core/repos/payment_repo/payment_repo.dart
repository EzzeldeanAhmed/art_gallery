import 'package:art_gallery/core/errors/failures.dart';
import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/payment_entity.dart';
import 'package:art_gallery/core/models/payment_model.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentsRepo {
  Future<Either<Failure, List<PaymentEntity>>> getPayments();
  Future<Either<Failure, List<PaymentModel>>> getPaymentsUser(String userId);
  Future<Either<Failure, PaymentEntity>> getPayment(String name);
  Future<Either<Failure, void>> addPayment(PaymentEntity addPaymentInputEntity);
  Future<Either<Failure, void>> updatePayment(
      PaymentEntity updatePaymentEntity);
  Future<Either<Failure, void>> deletePayment(String documentId);
}
