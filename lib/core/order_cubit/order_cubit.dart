import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/cart_entity.dart';
import 'package:art_gallery/core/models/cart_model.dart';
import 'package:art_gallery/core/models/order_model.dart';
import 'package:art_gallery/core/repos/cart_repo/cart_repo.dart';
import 'package:art_gallery/core/repos/order_repo/order_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.orderRepo) : super(OrderInitial());
  final OrderRepo orderRepo;
  Future<void> getOrder(userId) async {
    emit(OrderLoading());
    final result = await orderRepo.getOrdersByUserId(userId);
    result.fold(
      (failure) => emit(OrderFailure(failure.message)),
      (order) => emit(OrderSuccess(order)),
    );
  }
}
