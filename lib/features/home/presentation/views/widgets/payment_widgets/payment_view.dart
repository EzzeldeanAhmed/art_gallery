import 'package:art_gallery/core/cart_cubit/cart_cubit.dart';
import 'package:art_gallery/core/order_cubit/order_cubit.dart';
import 'package:art_gallery/core/payment_cubit/payment_cubit.dart';
import 'package:art_gallery/core/repos/cart_repo/cart_repo.dart';
import 'package:art_gallery/core/repos/order_repo/order_repo.dart';
import 'package:art_gallery/core/repos/payment_repo/payment_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/cart_widgets/cart_page.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/order_widgets/order_page.dart';
import 'package:art_gallery/features/home/presentation/views/widgets/payment_widgets/payment_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsView extends StatelessWidget {
  const PaymentsView({super.key});
  static const routeName = 'cart_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentsCubit(
        getIt.get<PaymentsRepo>(),
      ),
      child: PaymentListScreen(),
    );
  }
}
