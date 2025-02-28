part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderFailure extends OrderState {
  final String errMessage;

  OrderFailure(this.errMessage);
}

final class OrderSuccess extends OrderState {
  final List<OrderModel> order;
  OrderSuccess(this.order);
}

final class ItemRemovedSuccess extends OrderState {
  ItemRemovedSuccess();
}
