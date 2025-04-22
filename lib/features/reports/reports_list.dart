import 'dart:collection';

import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart'; // For formatting dates

class ReportsListScreen extends StatelessWidget {
  final List<ReportModel> reports = [
    ReportModel(
      title: 'Types of Artworks Summary',
      icon: Icons.pie_chart,
      reportBuilder: () => PieChartScreen(
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
      title: 'Line Chart',
      icon: Icons.show_chart,
      reportBuilder: () => LineChartScreen(
        reportName: 'Monthly Sales Analysis',
        date: DateTime.now(),
      ),
    ),
    ReportModel(
      title: 'Bar Chart',
      icon: Icons.bar_chart,
      reportBuilder: () => BarChartScreen(
        reportName: 'Weekly Sales Analysis',
        date: DateTime.now(),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 2,
            child: ListTile(
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

class PieChartScreen extends StatelessWidget {
  final String reportName;
  final DateTime date;

  PieChartScreen({required this.reportName, required this.date});

  Future<List<ArtworkEntity>> getArtworks() async {
    var artworkRepo = getIt.get<ArtworksRepo>();
    List<ArtworkEntity> artworks = [];
    var result = await artworkRepo.getMainArtworks();
    if (result.isRight()) {
      artworks = result.getOrElse(() => []);
    } else {}
    return artworks;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getArtworks(),
        builder: (context, AsyncSnapshot<List<ArtworkEntity>> snapshot) {
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
            HashMap<String, double> TypesOfArtworks = HashMap<String, double>();
            for (var artwork in snapshot.data!) {
              if (TypesOfArtworks.containsKey(artwork.type)) {
                TypesOfArtworks[artwork.type] =
                    TypesOfArtworks[artwork.type]! + 1;
              } else {
                TypesOfArtworks[artwork.type] = 1;
              }
            }
            List<_ChartData> chartData = [];
            TypesOfArtworks.forEach((key, value) {
              chartData
                  .add(_ChartData(key, (value / snapshot.data!.length) * 100));
            });
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
                      child: SfCircularChart(
                        title: ChartTitle(
                            text: "Types of Artworks",
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        legend: Legend(
                            overflowMode: LegendItemOverflowMode.wrap,
                            isVisible: true,
                            textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            position: LegendPosition.top),
                        series: <PieSeries<_ChartData, String>>[
                          PieSeries<_ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (_ChartData data, _) => data.category,
                            yValueMapper: (_ChartData data, _) => data.sales,
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(
                                  fontSize: 64, fontWeight: FontWeight.bold),
                              labelPosition: ChartDataLabelPosition.inside,
                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                return Text(
                                  '${data.sales.toStringAsFixed(0)}%',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
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
                      'Objective: This report shows the distribution of different types of artworks in the gallery.',
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

class PieChartScreenForSale extends StatelessWidget {
  final String reportName;
  final DateTime date;

  PieChartScreenForSale({required this.reportName, required this.date});

  Future<List<ArtworkEntity>> getArtworks() async {
    var artworkRepo = getIt.get<ArtworksRepo>();
    List<ArtworkEntity> artworks = [];
    var result = await artworkRepo.getMainArtworks();
    if (result.isRight()) {
      artworks = result.getOrElse(() => []);
    } else {}
    return artworks;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getArtworks(),
        builder: (context, AsyncSnapshot<List<ArtworkEntity>> snapshot) {
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
            HashMap<String, double> TypesOfArtworks = HashMap<String, double>();
            for (var artwork in snapshot.data!) {
              if (TypesOfArtworks.containsKey(
                  artwork.forSale! ? 'For Sale' : 'Not For Sale')) {
                TypesOfArtworks[artwork.forSale!
                    ? 'For Sale'
                    : 'Not For Sale'] = TypesOfArtworks[
                        artwork.forSale! ? 'For Sale' : 'Not For Sale']! +
                    1;
              } else {
                TypesOfArtworks[
                    artwork.forSale! ? 'For Sale' : 'Not For Sale'] = 1;
              }
            }
            List<_ChartData> chartData = [];
            TypesOfArtworks.forEach((key, value) {
              chartData
                  .add(_ChartData(key, (value / snapshot.data!.length) * 100));
            });
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
                      child: SfCircularChart(
                        title: ChartTitle(
                            text: "Types of Artworks",
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        legend: Legend(
                            overflowMode: LegendItemOverflowMode.wrap,
                            isVisible: true,
                            textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            position: LegendPosition.top),
                        series: <PieSeries<_ChartData, String>>[
                          PieSeries<_ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (_ChartData data, _) => data.category,
                            yValueMapper: (_ChartData data, _) => data.sales,
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(
                                  fontSize: 64, fontWeight: FontWeight.bold),
                              labelPosition: ChartDataLabelPosition.inside,
                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                return Text(
                                  '${data.sales.toStringAsFixed(0)}%',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
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
                      'Objective: This report shows the distribution of artworks in the gallery that are offered for sale or not.',
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
