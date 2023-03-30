import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartDetail extends StatefulWidget {
  const ChartDetail({super.key});

  @override
  State<ChartDetail> createState() => _ChartDetailState();
}

class _ChartDetailState extends State<ChartDetail> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double nRecommendations = 31.6;
    double pRecommendations = 30.2;
    double kRecommendations = 28.3;
    double pHRecommendations = 6.43;

    final List<ChartData> nData = [
      ChartData(1, [nRecommendations, 29]),
      ChartData(2, [nRecommendations, 15]),
      ChartData(3, [nRecommendations, 27]),
      ChartData(4, [nRecommendations, 37]),
      ChartData(5, [nRecommendations, 36]),
    ];
    final List<ChartData> pData = [
      ChartData(1, [pRecommendations, 29]),
      ChartData(2, [pRecommendations, 27]),
      ChartData(3, [pRecommendations, 26]),
      ChartData(4, [pRecommendations, 31]),
      ChartData(5, [pRecommendations, 36]),
    ];
    final List<ChartData> kData = [
      ChartData(1, [kRecommendations, 28]),
      ChartData(2, [kRecommendations, 27]),
      ChartData(3, [kRecommendations, 25]),
      ChartData(4, [kRecommendations, 33]),
      ChartData(5, [kRecommendations, 36]),
    ];
    final List<ChartData> pHData = [
      ChartData(1, [pHRecommendations, 6.8]),
      ChartData(2, [pHRecommendations, 6.5]),
      ChartData(3, [pHRecommendations, 6.1]),
      ChartData(4, [pHRecommendations, 7.2]),
      ChartData(5, [pHRecommendations, 7.5]),
    ];

    List<SplineAreaSeries> generateNitrogenSeries(List<ChartData> nData) {
      List<SplineAreaSeries> splines = [];
      for (int i = 0; i < nData.first.y!.length; i++) {
        splines.add(
          SplineAreaSeries<ChartData, String>(
            opacity: 0.5,
            splineType: SplineType.natural,
            dataSource: nData,
            xValueMapper: (ChartData data, _) => data.x.toString(),
            yValueMapper: (ChartData data, _) => data.y![i],
          ),
        );
      }
      return splines;
    }

    List<SplineAreaSeries> generatePhosphorusSeries(List<ChartData> pData) {
      List<SplineAreaSeries> splines = [];
      for (int i = 0; i < pData.first.y!.length; i++) {
        splines.add(
          SplineAreaSeries<ChartData, String>(
            opacity: 0.5,
            splineType: SplineType.natural,
            dataSource: pData,
            xValueMapper: (ChartData data, _) => data.x.toString(),
            yValueMapper: (ChartData data, _) => data.y![i],
          ),
        );
      }
      return splines;
    }

    List<SplineAreaSeries> generatePottasiumSeries(List<ChartData> kData) {
      List<SplineAreaSeries> splines = [];
      for (int i = 0; i < kData.first.y!.length; i++) {
        splines.add(
          SplineAreaSeries<ChartData, String>(
            opacity: 0.5,
            splineType: SplineType.natural,
            dataSource: kData,
            xValueMapper: (ChartData data, _) => data.x.toString(),
            yValueMapper: (ChartData data, _) => data.y![i],
          ),
        );
      }
      return splines;
    }

    List<SplineAreaSeries> generatepHSeries(List<ChartData> pHData) {
      List<SplineAreaSeries> splines = [];
      for (int i = 0; i < pHData.first.y!.length; i++) {
        splines.add(
          SplineAreaSeries<ChartData, String>(
            opacity: 0.5,
            splineType: SplineType.natural,
            dataSource: pHData,
            xValueMapper: (ChartData data, _) => data.x.toString(),
            yValueMapper: (ChartData data, _) => data.y![i],
          ),
        );
      }
      return splines;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Chart Details',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // Nitrogen Chart
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black26,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.4,
                    child: SizedBox(
                      width: screenWidth,
                      child: Column(children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: screenWidth,
                            height: 20,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'Nitrogen',
                                style: TextStyle(
                                  color: Theme.of(context).splashColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 10,
                          child: SfCartesianChart(
                            legend: Legend(
                              isVisible: true,
                              position: LegendPosition.bottom,
                              textStyle: TextStyle(
                                color: Theme.of(context).primaryColor.withOpacity(.2),
                                fontSize: 10,
                              ),
                            ),
                            palette: <Color>[
                              Theme.of(context).unselectedWidgetColor,
                              Theme.of(context).indicatorColor,
                              Theme.of(context).dialogBackgroundColor,
                              Theme.of(context).canvasColor,
                            ],
                            primaryXAxis: CategoryAxis(
                              labelStyle: const TextStyle(
                                fontSize: 10,
                              ),
                              majorGridLines: const MajorGridLines(width: 0.2),
                              majorTickLines: const MajorTickLines(width: 0.2),
                              minorTickLines: const MinorTickLines(width: 0.2),
                              minorGridLines: const MinorGridLines(width: 0.2),
                              // borderWidth: 0.2,
                              maximumLabels: 5,
                            ),
                            primaryYAxis: CategoryAxis(
                              labelStyle: const TextStyle(
                                fontSize: 10,
                              ),
                              maximumLabels: 1,
                              majorGridLines: const MajorGridLines(width: 0.2),
                              majorTickLines: const MajorTickLines(width: 0.2),
                              minorTickLines: const MinorTickLines(width: 0.2),
                              minorGridLines: const MinorGridLines(width: 0.2),
                            ),
                            // primaryYAxis: CategoryAxis(labelStyle: TextStyle(fontSize: 12)),
                            series: generateNitrogenSeries(nData),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                // Phosphorus
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black26,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.4,
                    child: SizedBox(
                      width: screenWidth,
                      child: Column(children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: screenWidth,
                            height: 20,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'Phosphorus',
                                style: TextStyle(
                                  color: Theme.of(context).splashColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 10,
                          child: SfCartesianChart(
                            legend: Legend(
                              isVisible: true,
                              position: LegendPosition.bottom,
                              textStyle: TextStyle(
                                color: Theme.of(context).primaryColor.withOpacity(.2),
                                fontSize: 10,
                              ),
                            ),
                            palette: <Color>[
                              Theme.of(context).unselectedWidgetColor,
                              Theme.of(context).indicatorColor,
                              Theme.of(context).dialogBackgroundColor,
                              Theme.of(context).canvasColor,
                            ],
                            primaryXAxis: CategoryAxis(
                              labelStyle: const TextStyle(
                                fontSize: 10,
                              ),
                              majorGridLines: const MajorGridLines(width: 0.2),
                              majorTickLines: const MajorTickLines(width: 0.2),
                              minorTickLines: const MinorTickLines(width: 0.2),
                              minorGridLines: const MinorGridLines(width: 0.2),
                              // borderWidth: 0.2,
                              maximumLabels: 5,
                            ),
                            primaryYAxis: CategoryAxis(
                              labelStyle: const TextStyle(
                                fontSize: 10,
                              ),
                              maximumLabels: 1,
                              majorGridLines: const MajorGridLines(width: 0.2),
                              majorTickLines: const MajorTickLines(width: 0.2),
                              minorTickLines: const MinorTickLines(width: 0.2),
                              minorGridLines: const MinorGridLines(width: 0.2),
                            ),
                            // primaryYAxis: CategoryAxis(labelStyle: TextStyle(fontSize: 12)),
                            series: generatePhosphorusSeries(pData),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                Card(
                  // color: Color.fromARGB(255, 239, 246, 255),
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  // clipBehavior: Clip.hardEdge,
                  elevation: 5,
                  shadowColor: Colors.black26,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.4,
                    child: SizedBox(
                      width: screenWidth,
                      child: Column(children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: screenWidth,
                            height: 20,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'Pottasium',
                                style: TextStyle(
                                  color: Theme.of(context).splashColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 10,
                          child: SfCartesianChart(
                            legend: Legend(
                              isVisible: true,
                              position: LegendPosition.bottom,
                              textStyle: TextStyle(
                                color: Theme.of(context).primaryColor.withOpacity(.2),
                                fontSize: 10,
                              ),
                            ),
                            palette: <Color>[
                              Theme.of(context).unselectedWidgetColor,
                              Theme.of(context).indicatorColor,
                              Theme.of(context).dialogBackgroundColor,
                              Theme.of(context).canvasColor,
                            ],
                            primaryXAxis: CategoryAxis(
                              labelStyle: const TextStyle(
                                fontSize: 10,
                              ),
                              majorGridLines: const MajorGridLines(width: 0.2),
                              majorTickLines: const MajorTickLines(width: 0.2),
                              minorTickLines: const MinorTickLines(width: 0.2),
                              minorGridLines: const MinorGridLines(width: 0.2),
                              // borderWidth: 0.2,
                              maximumLabels: 5,
                            ),
                            primaryYAxis: CategoryAxis(
                              labelStyle: const TextStyle(
                                fontSize: 10,
                              ),
                              maximumLabels: 1,
                              majorGridLines: const MajorGridLines(width: 0.2),
                              majorTickLines: const MajorTickLines(width: 0.2),
                              minorTickLines: const MinorTickLines(width: 0.2),
                              minorGridLines: const MinorGridLines(width: 0.2),
                            ),
                            // primaryYAxis: CategoryAxis(labelStyle: TextStyle(fontSize: 12)),
                            series: generatePottasiumSeries(kData),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                Card(
                  // color: Color.fromARGB(255, 239, 246, 255),
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  // clipBehavior: Clip.hardEdge,
                  elevation: 5,
                  shadowColor: Colors.black26,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.4,
                    child: SizedBox(
                      width: screenWidth,
                      child: Column(children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: screenWidth,
                            height: 20,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'pH',
                                style: TextStyle(
                                  color: Theme.of(context).splashColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 10,
                          child: SfCartesianChart(
                            legend: Legend(
                              isVisible: true,
                              position: LegendPosition.bottom,
                              textStyle: TextStyle(
                                color: Theme.of(context).primaryColor.withOpacity(.2),
                                fontSize: 10,
                              ),
                            ),
                            palette: <Color>[
                              Theme.of(context).unselectedWidgetColor,
                              Theme.of(context).indicatorColor,
                              Theme.of(context).dialogBackgroundColor,
                              Theme.of(context).canvasColor,
                            ],
                            primaryXAxis: CategoryAxis(
                              labelStyle: const TextStyle(
                                fontSize: 10,
                              ),
                              majorGridLines: const MajorGridLines(width: 0.2),
                              majorTickLines: const MajorTickLines(width: 0.2),
                              minorTickLines: const MinorTickLines(width: 0.2),
                              minorGridLines: const MinorGridLines(width: 0.2),
                              // borderWidth: 0.2,
                              maximumLabels: 5,
                            ),
                            primaryYAxis: CategoryAxis(
                              labelStyle: const TextStyle(
                                fontSize: 10,
                              ),
                              maximumLabels: 1,
                              majorGridLines: const MajorGridLines(width: 0.2),
                              majorTickLines: const MajorTickLines(width: 0.2),
                              minorTickLines: const MinorTickLines(width: 0.2),
                              minorGridLines: const MinorGridLines(width: 0.2),
                            ),
                            // primaryYAxis: CategoryAxis(labelStyle: TextStyle(fontSize: 12)),
                            series: generatepHSeries(pHData),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final List? y;
}
