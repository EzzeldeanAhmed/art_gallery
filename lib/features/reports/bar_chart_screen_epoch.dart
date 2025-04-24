import 'dart:collection';

import 'package:art_gallery/core/models/artwork_entity.dart';
import 'package:art_gallery/core/repos/artworks_repo/artworks_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:art_gallery/core/utils/app_images.dart';
import 'package:art_gallery/core/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartScreenEpoch extends StatelessWidget {
  final String reportName;
  final DateTime date;

  BarChartScreenEpoch({required this.reportName, required this.date});

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
            HashMap<String, double> EpochesOfArtworks =
                HashMap<String, double>();
            for (var artwork in snapshot.data!) {
              if (EpochesOfArtworks.containsKey(artwork.epoch)) {
                EpochesOfArtworks[artwork.epoch] =
                    EpochesOfArtworks[artwork.epoch]! + 1;
              } else {
                EpochesOfArtworks[artwork.epoch] = 1;
              }
            }
            List<_ChartData> chartData = [];
            EpochesOfArtworks.forEach((key, value) {
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
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        title: ChartTitle(
                            text: reportName,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        legend: Legend(
                            isVisible: false,
                            textStyle: TextStyle(fontWeight: FontWeight.bold)),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <BarSeries<_ChartData, String>>[
                          BarSeries<_ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (_ChartData data, _) => data.category,
                            yValueMapper: (_ChartData data, _) => data.sales,
                            color: AppColors.lightPrimaryColor,
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              // textStyle: TextStyle(
                              //     fontSize: 64, fontWeight: FontWeight.bold),
                              // labelPosition: ChartDataLabelPosition.inside,
                              labelIntersectAction: LabelIntersectAction.shift,

                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                return Text(
                                  '${data.sales.toStringAsFixed(1)}%',
                                  style: TextStyle(
                                      fontSize: 12,
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
                      'Objective: This chart shows the percentage of artworks from different epochs in the Art museum gallery.',
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
  _ChartData(this.category, this.sales);

  final String category;
  final double sales;
}
