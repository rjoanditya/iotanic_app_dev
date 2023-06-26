import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../controller/land_controller.dart';
import '../../model/chartData.dart';

class ChartDetail extends StatefulWidget {
  const ChartDetail({super.key});

  @override
  State<ChartDetail> createState() => _ChartDetailState();
}

class _ChartDetailState extends State<ChartDetail> {
  var data = Get.arguments;
  Land landC = Get.put(Land());

  List<ChartData>? nData;
  List<ChartData>? pData;
  List<ChartData>? kData;
  List<ChartData>? phData;

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the function to fetch the data here
  }

  Future<void> fetchData() async {
    final List<ChartData> nChart = await landC.getNitrogen(data['id'], data['variety']['id']);
    final List<ChartData> pChart = await landC.getPhosporus(data['id'], data['variety']['id']);
    final List<ChartData> kChart = await landC.getPotassium(data['id'], data['variety']['id']);
    final List<ChartData> phChart = await landC.getPH(data['id'], data['variety']['id']);

    setState(() {
      nData = nChart;
      pData = pChart;
      kData = kChart;
      phData = phChart;
    });
    {}
  }

  final List legend = ['Ideal', 'Pengukuran', '', '', ''];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<SplineAreaSeries> generateNitrogenSeries(List<ChartData> nData) {
      List<SplineAreaSeries> splines = [];
      for (int i = 0; i < nData.first.y!.length; i++) {
        splines.add(
          SplineAreaSeries<ChartData, String>(
            legendItemText: legend[i],
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
            legendItemText: legend[i],
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
            legendItemText: legend[i],
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

    List<SplineAreaSeries> generatepHSeries(List<ChartData> phData) {
      List<SplineAreaSeries> splines = [];
      for (int i = 0; i < phData.first.y!.length; i++) {
        splines.add(
          SplineAreaSeries<ChartData, String>(
            legendItemText: legend[i],
            opacity: 0.5,
            splineType: SplineType.natural,
            dataSource: phData,
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
                            series: generateNitrogenSeries(nData ??
                                [
                                  ChartData(1, [0, 0])
                                ]),
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
                            series: generatePhosphorusSeries(pData ??
                                [
                                  ChartData(1, [0, 0, 0, 0])
                                ]),
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
                            series: generatePottasiumSeries(kData ??
                                [
                                  ChartData(1, [0, 0, 0, 0])
                                ]),
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
                            series: generatepHSeries(phData ??
                                [
                                  ChartData(1, [0, 0, 0, 0])
                                ]),
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
