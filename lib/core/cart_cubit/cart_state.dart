part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartFailure extends CartState {
  final String errMessage;

  CartFailure(this.errMessage);
}

final class CartSuccess extends CartState {
  final CartModel cart;
  CartSuccess(this.cart);
}
