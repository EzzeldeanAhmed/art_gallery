part of 'payment_cubit.dart';

@immutable
sealed class PaymentsState {}

final class PaymentsInitial extends PaymentsState {}

final class PaymentsLoading extends PaymentsState {}

final class PaymentsFailure extends PaymentsState {
  final String errMessage;

  PaymentsFailure(this.errMessage);
}

final class PaymentsSuccess extends PaymentsState {
  final List<PaymentModel> payment;
  PaymentsSuccess(this.payment);
}

final class ItemRemovedSuccess extends PaymentsState {
  ItemRemovedSuccess();
}
