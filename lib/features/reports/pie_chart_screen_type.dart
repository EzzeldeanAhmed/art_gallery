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

class PieChartScreenTypes extends StatelessWidget {
  final String reportName;
  final DateTime date;

  PieChartScreenTypes({required this.reportName, required this.date});

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

class _ChartData {
  _ChartData(this.category, this.sales);

  final String category;
  final double sales;
}
