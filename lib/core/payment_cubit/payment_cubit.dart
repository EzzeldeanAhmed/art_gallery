import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/cart_entity.dart';
import 'package:art_gallery/core/models/cart_model.dart';
import 'package:art_gallery/core/models/order_model.dart';
import 'package:art_gallery/core/models/payment_model.dart';
import 'package:art_gallery/core/repos/cart_repo/cart_repo.dart';
import 'package:art_gallery/core/repos/order_repo/order_repo.dart';
import 'package:art_gallery/core/repos/payment_repo/payment_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_state.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit(this.paymentRepo) : super(PaymentsInitial());
  final PaymentsRepo paymentRepo;
  Future<void> getPayments(userId) async {
    emit(PaymentsLoading());
    final result = await paymentRepo.getPaymentsUser(userId);
    result.fold(
      (failure) => emit(PaymentsFailure(failure.message)),
      (payment) => emit(PaymentsSuccess(payment)),
    );
  }
}
