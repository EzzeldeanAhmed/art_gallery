import 'package:art_gallery/core/models/payment_model.dart';
import 'package:art_gallery/core/order_cubit/order_cubit.dart';
import 'package:art_gallery/core/payment_cubit/payment_cubit.dart';
import 'package:art_gallery/core/repos/payment_repo/payment_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PaymentListScreen extends StatefulWidget {
  PaymentListScreen();

  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}

class _PaymentListScreenState extends State<PaymentListScreen> {
  @override
  void initState() {
    var userId = getIt.get<AuthRepo>().getSavedUserData().uId;
    context.read<PaymentsCubit>().getPayments(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsCubit, PaymentsState>(builder: (context, state) {
      if (state is PaymentsLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is PaymentsFailure) {
        return Center(child: Text(state.errMessage));
      } else if (state is PaymentsSuccess) {
        return PaymentListView(payments: state.payment);
      } else {
        return Center(child: Text('No payments found'));
      }
    });
  }

  Widget PaymentListView({required List<PaymentModel> payments}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payments',
          style: TextStyles.bold23.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightPrimaryColor,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: payments.length,
        itemBuilder: (context, index) {
          final payment = payments[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: ListTile(
                leading: Icon(
                  payment.status == 'Success'
                      ? Icons.check_circle
                      : (payment.status == "refunded"
                          ? Icons.cancel
                          : Icons.pending),
                  color: payment.status == 'Success'
                      ? Colors.green
                      : (payment.status == "refunded"
                          ? Colors.red
                          : Colors.orange),
                ),
                title: Text(
                  '${payment.type} - \$${payment.amount!.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Method: ${payment.paymentMethod}',
                        style: TextStyle(fontSize: 16)),
                    Text('Status: ${payment.status}',
                        style: TextStyle(fontSize: 16)),
                    Text('Date: ${DateFormat.yMMMd().format(payment.date!)}',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
                isThreeLine: true,

                // trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Handle tap to show more details
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
