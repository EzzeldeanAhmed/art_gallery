import 'dart:collection';

import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/models/payment_entity.dart';
import 'package:art_gallery/core/models/payment_model.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/repos/payment_repo/payment_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartScreenPayments extends StatelessWidget {
  final String reportName;
  final DateTime date;

  LineChartScreenPayments({required this.reportName, required this.date});

  Future<HashMap<String, List<_ChartData>>> getPayments() async {
    var paymentRepo = getIt.get<PaymentsRepo>();
    List<PaymentEntity> payments = [];
    var result = await paymentRepo.getPayments();
    if (result.isRight()) {
      payments = result.getOrElse(() => []);
    } else {}
    HashMap<String, HashMap<String, double>> TypesOfPayment = HashMap<String,
        HashMap<String, double>>(); // type => HashMap<Month, amount>
    for (var payment in payments) {
      String month = DateFormat.MMMM().format(payment.date!);
      int monthNumber = payment.date!.month;
      if (TypesOfPayment.containsKey(payment.type)) {
        if (TypesOfPayment[payment.type]!.containsKey(month)) {
          TypesOfPayment[payment.type]![month] =
              TypesOfPayment[payment.type]![month]! + payment.amount!;
        } else {
          TypesOfPayment[payment.type]![month] = payment.amount!;
        }
      } else {
        HashMap<String, double> monthAmount = HashMap<String, double>();
        monthAmount[month] = payment.amount!;
        TypesOfPayment[payment.type!] = monthAmount;
      }
    }
    for (var payment in payments) {
      String month = DateFormat.MMMM().format(payment.date!);
      if (TypesOfPayment.containsKey("Total Income")) {
        if (TypesOfPayment["Total Income"]!.containsKey(month)) {
          TypesOfPayment["Total Income"]![month] =
              TypesOfPayment["Total Income"]![month]! + payment.amount!;
        } else {
          TypesOfPayment["Total Income"]![month] = payment.amount!;
        }
      } else {
        HashMap<String, double> monthAmount = HashMap<String, double>();
        monthAmount[month] = payment.amount!;
        TypesOfPayment["Total Income"] = monthAmount;
      }
    }
    HashMap<String, int> monthNumbers = HashMap<String, int>();
    monthNumbers["January"] = 1;
    monthNumbers["February"] = 2;
    monthNumbers["March"] = 3;
    monthNumbers["April"] = 4;
    monthNumbers["May"] = 5;
    monthNumbers["June"] = 6;
    monthNumbers["July"] = 7;
    monthNumbers["August"] = 8;
    monthNumbers["September"] = 9;
    monthNumbers["October"] = 10;
    monthNumbers["November"] = 11;
    monthNumbers["December"] = 12;
    HashMap<String, List<_ChartData>> chartData =
        HashMap<String, List<_ChartData>>();
    TypesOfPayment.forEach((key, value) {
      List<_ChartData> data = [];
      value.forEach((month, amount) {
        data.add(_ChartData(month, amount, monthNumbers[month]!));
      });
      data.sort((a, b) => a.month.compareTo(b.month));
      chartData[key] = data;
    });

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPayments(),
        builder: (context,
            AsyncSnapshot<HashMap<String, List<_ChartData>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(
                color: AppColors.lightPrimaryColor,
              ),
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No artworks found'));
          } else {
            HashMap<String, List<_ChartData>> chartData = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  '$reportName',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              body: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: Image.asset(Assets.imagesMus),
                    title: Text(
                      'Art Museum Gallery',
                      //textAlign: TextAlign.center,
                      style: TextStyles.bold19.copyWith(
                        fontSize: 24,
                        //color: AppColors.primaryColor
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Date: ${DateFormat.yMMMd().format(date)}\nName: $reportName',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Center(
                      child: SfCartesianChart(
                        palette: [
                          Colors.blue,
                          Colors.red,
                          Colors.green,
                        ],
                        primaryXAxis: CategoryAxis(),
                        title: ChartTitle(
                            text: reportName,
                            textStyle: TextStyle(fontWeight: FontWeight.bold)),
                        legend: Legend(isVisible: true),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <LineSeries<_ChartData, String>>[
                          LineSeries<_ChartData, String>(
                            name: 'Total Income',
                            dataSource: chartData["Total Income"]!,
                            xValueMapper: (_ChartData data, _) => data.category,
                            yValueMapper: (_ChartData data, _) => data.sales,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                          ),
                          LineSeries<_ChartData, String>(
                            name: 'Exhibition Ticket',
                            dataSource: chartData["Exhibition Ticket"]!,
                            xValueMapper: (_ChartData data, _) => data.category,
                            yValueMapper: (_ChartData data, _) => data.sales,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                          ),
                          LineSeries<_ChartData, String>(
                            name: 'Order',
                            dataSource: chartData["Order"]!,
                            xValueMapper: (_ChartData data, _) => data.category,
                            yValueMapper: (_ChartData data, _) => data.sales,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Objective: This chart shows the total income of making orders and booking tickets individually and the total income to the system from the two together..',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            );
          }
        });
  }
}

class _ChartData {
  _ChartData(this.category, this.sales, this.month);

  final String category;
  final double sales;
  final int month;
}
