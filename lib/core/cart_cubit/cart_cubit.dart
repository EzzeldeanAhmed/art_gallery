import 'package:art_gallery/core/models/artist_entity.dart';
import 'package:art_gallery/core/models/cart_entity.dart';
import 'package:art_gallery/core/models/cart_model.dart';
import 'package:art_gallery/core/repos/cart_repo/cart_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepo) : super(CartInitial());
  final CartRepo cartRepo;
  Future<void> getCart(userId) async {
    emit(CartLoading());
    final result = await cartRepo.getCart(userId);
    result.fold(
      (failure) => emit(CartFailure(failure.message)),
      (cart) => emit(CartSuccess(cart)),
    );
  }
}
