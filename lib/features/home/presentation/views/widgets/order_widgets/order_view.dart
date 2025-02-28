import 'package:art_gallery/core/cart_cubit/cart_cubit.dart';
import 'package:art_gallery/core/order_cubit/order_cubit.dart';
import 'package:art_gallery/core/repos/cart_repo/cart_repo.dart';
import 'package:art_gallery/core/repos/order_repo/order_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/cart_widgets/cart_page.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/order_widgets/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});
  static const routeName = 'cart_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(
        getIt.get<OrderRepo>(),
      ),
      child: OrderPage(),
    );
  }
}
