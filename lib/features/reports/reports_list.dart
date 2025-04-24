import 'dart:collection';

import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/features/reports/bar_chart_screen_epoch.dart';
import 'package:art_gallery/features/reports/line_chart_screen_payments.dart';
import 'package:art_gallery/features/reports/pie_chart_screen_for_sale.dart';
import 'package:art_gallery/features/reports/pie_chart_screen_type.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart'; // For formatting dates

class ReportsListScreen extends StatelessWidget {
  final List<ReportModel> reports = [
    ReportModel(
      title: 'Types of Artworks Summary',
      icon: Icons.pie_chart,
      reportBuilder: () => PieChartScreenTypes(
        reportName: 'Types of Artworks Summary',
        date: DateTime.now(),
      ),
    ),
    ReportModel(
      title: 'Condition of Artworks Summary',
      icon: Icons.pie_chart,
      reportBuilder: () => PieChartScreenForSale(
        reportName: 'Condition of Artworks Summary',
        date: DateTime.now(),
      ),
    ),
    ReportModel(
      title: 'Epochs of Artworks Summary',
      icon: Icons.bar_chart,
      reportBuilder: () => BarChartScreenEpoch(
        reportName: 'Epochs of Artworks Summary',
        date: DateTime.now(),
      ),
    ),
    ReportModel(
      title: 'Total Income Analysis',
      icon: Icons.show_chart,
      reportBuilder: () => LineChartScreenPayments(
        reportName: 'Total Income Analysis',
        date: DateTime.now(),
      ),
    ),
    // ReportModel(
    //   title: 'Bar Chart',
    //   icon: Icons.bar_chart,
    //   reportBuilder: () => BarChartScreen(
    //     reportName: 'Weekly Sales Analysis',
    //     date: DateTime.now(),
    //   ),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            )),
        backgroundColor: AppColors.lightPrimaryColor,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Icon(report.icon, color: Theme.of(context).primaryColor),
              title: Text(report.title,
                  style: TextStyle(fontWeight: FontWeight.w600)),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => report.reportBuilder()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ReportModel {
  final String title;
  final IconData icon;
  final Widget Function() reportBuilder;

  ReportModel({
    required this.title,
    required this.icon,
    required this.reportBuilder,
  });
}

class LineChartScreen extends StatelessWidget {
  final String reportName;
  final DateTime date;

  LineChartScreen({required this.reportName, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$reportName - ${DateFormat.yMMMd().format(date)}'),
      ),
      body: Center(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: reportName),
          legend: Legend(isVisible: true),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <LineSeries<_ChartData, String>>[
            LineSeries<_ChartData, String>(
              dataSource: [
                _ChartData('Jan', 35),
                _ChartData('Feb', 28),
                _ChartData('Mar', 34),
                _ChartData('Apr', 32),
                _ChartData('May', 40),
              ],
              xValueMapper: (_ChartData data, _) => data.category,
              yValueMapper: (_ChartData data, _) => data.sales,
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChartScreen extends StatelessWidget {
  final String reportName;
  final DateTime date;

  BarChartScreen({required this.reportName, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$reportName - ${DateFormat.yMMMd().format(date)}'),
      ),
      body: Center(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: reportName),
          legend: Legend(isVisible: true),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <BarSeries<_ChartData, String>>[
            BarSeries<_ChartData, String>(
              dataSource: [
                _ChartData('Mon', 8),
                _ChartData('Tue', 10),
                _ChartData('Wed', 14),
                _ChartData('Thu', 15),
                _ChartData('Fri', 13),
                _ChartData('Sat', 10),
                _ChartData('Sun', 6),
              ],
              xValueMapper: (_ChartData data, _) => data.category,
              yValueMapper: (_ChartData data, _) => data.sales,
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.category, this.sales);

  final String category;
  final double sales;
}
