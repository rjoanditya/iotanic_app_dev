import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../controller/land_controller.dart';
import '../../controller/measurement_controller.dart';
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

  Measurement measureC = Measurement();
  Future<void> fetchData() async {
    // dynamic measureData = measureC.getMeasurements(data['data']['id']);
    // dynamic optimalData = await measureData;
    // print(optimalData);

    final List<ChartData> nChart = await landC.getNitrogen(data['data']['id'], data['variety']['id']);
    final List<ChartData> pChart = await landC.getPhosporus(data['data']['id'], data['variety']['id']);
    final List<ChartData> kChart = await landC.getPotassium(data['data']['id'], data['variety']['id']);
    final List<ChartData> phChart = await landC.getPH(data['data']['id'], data['variety']['id']);

    setState(() {
      nData = nChart;
      pData = pChart;
      kData = kChart;
      phData = phChart;
    });
  }

  final List legend = ['Ideal', 'Actual'];

  @override
  Widget build(BuildContext context) {
    print(data['data']['id']);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<SplineAreaSeries> generateNitrogenSeries(List<ChartData> nData) {
      List<SplineAreaSeries> splines = [];
      for (int i = 0; i < nData.first.y!.length; i++) {
        splines.add(
          SplineAreaSeries<ChartData, String>(
            legendItemText: legend[i],
            name: legend[i],
            opacity: 0.5,
            splineType: SplineType.natural,
            dataSource: nData,
            markerSettings: const MarkerSettings(
              isVisible: true,
              height: 5,
              width: 5,
            ),
            xValueMapper: (ChartData data, _) => data.x.toString(),
            yValueMapper: (ChartData data, _) => data.y![i],
          ),
        );
      }
      return splines;
    }

    List<SplineAreaSeries> generatePhosphorusSeries(List<ChartData> pData) {
      List<SplineAreaSeries> splines = [];
      for (int i = 0; i < legend.length; i++) {
        splines.add(
          SplineAreaSeries<ChartData, String>(
            legendItemText: legend[i],
            name: legend[i],
            opacity: 0.5,
            splineType: SplineType.natural,
            dataSource: pData,
            markerSettings: const MarkerSettings(
              isVisible: true,
              height: 5,
              width: 5,
            ),
            xValueMapper: (ChartData data, _) => data.x.toString(),
            yValueMapper: (ChartData data, _) => data.y![i],
          ),
        );
      }
      return splines;
    }

    List<SplineAreaSeries> generatePottasiumSeries(List<ChartData> kData) {
      List<SplineAreaSeries> splines = [];
      for (int i = 0; i < legend.length; i++) {
        splines.add(
          SplineAreaSeries<ChartData, String>(
            legendItemText: legend[i],
            name: legend[i],
            opacity: 0.5,
            splineType: SplineType.natural,
            dataSource: kData,
            markerSettings: const MarkerSettings(
              isVisible: true,
              height: 5,
              width: 5,
            ),
            xValueMapper: (ChartData data, _) => data.x.toString(),
            yValueMapper: (ChartData data, _) => data.y![i],
          ),
        );
      }
      return splines;
    }

    List<SplineAreaSeries> generatepHSeries(List<ChartData> phData) {
      List<SplineAreaSeries> splines = [];
      for (int i = 0; i < legend.length; i++) {
        splines.add(
          SplineAreaSeries<ChartData, String>(
            legendItemText: legend[i],
            name: legend[i],
            opacity: 0.5,
            splineType: SplineType.natural,
            dataSource: phData,
            markerSettings: const MarkerSettings(
              isVisible: true,
              height: 5,
              width: 5,
            ),
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
          'Detail Grafik',
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
                              Theme.of(context).splashColor,
                              Theme.of(context).unselectedWidgetColor,
                              // Theme.of(context).indicatorColor,
                              // Theme.of(context).dialogBackgroundColor,
                              // Theme.of(context).canvasColor,
                            ],
                            primaryXAxis: CategoryAxis(
                              // visibleMinimum: 1,
                              majorGridLines: const MajorGridLines(width: 0),
                              labelPlacement: LabelPlacement.onTicks,
                            ),
                            primaryYAxis: NumericAxis(
                              axisLine: const AxisLine(width: 0),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              majorTickLines: const MajorTickLines(size: 0),
                            ),
                            // primaryYAxis: CategoryAxis(labelStyle: TextStyle(fontSize: 12)),
                            // primaryYAxis: CategoryAxis(labelStyle: TextStyle(fontSize: 12)),
                            series: generateNitrogenSeries(nData ??
                                [
                                  ChartData(1, [0, 0])
                                ]),
                            tooltipBehavior: TooltipBehavior(enable: true),
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
                              Theme.of(context).splashColor,
                              Theme.of(context).unselectedWidgetColor,
                              // Theme.of(context).indicatorColor,
                              // Theme.of(context).dialogBackgroundColor,
                              // Theme.of(context).canvasColor,
                            ],
                            primaryXAxis: CategoryAxis(
                              // visibleMinimum: 1,
                              majorGridLines: const MajorGridLines(width: 0),
                              labelPlacement: LabelPlacement.onTicks,
                            ),
                            primaryYAxis: NumericAxis(
                              axisLine: const AxisLine(width: 0),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              majorTickLines: const MajorTickLines(size: 0),
                            ),
                            // primaryYAxis: CategoryAxis(labelStyle: TextStyle(fontSize: 12)),
                            series: generatePhosphorusSeries(pData ??
                                [
                                  ChartData(1, [0, 0, 0, 0])
                                ]),
                            tooltipBehavior: TooltipBehavior(enable: true),
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
                              Theme.of(context).splashColor,
                              Theme.of(context).unselectedWidgetColor,
                              // Theme.of(context).indicatorColor,
                              // Theme.of(context).dialogBackgroundColor,
                              // Theme.of(context).canvasColor,
                            ],
                            primaryXAxis: CategoryAxis(
                              // visibleMinimum: 1,
                              majorGridLines: const MajorGridLines(width: 0),
                              labelPlacement: LabelPlacement.onTicks,
                            ),
                            primaryYAxis: NumericAxis(
                              axisLine: const AxisLine(width: 0),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              majorTickLines: const MajorTickLines(size: 0),
                            ),
                            // primaryYAxis: CategoryAxis(labelStyle: TextStyle(fontSize: 12)),
                            series: generatePottasiumSeries(kData ??
                                [
                                  ChartData(1, [0, 0, 0, 0])
                                ]),
                            tooltipBehavior: TooltipBehavior(enable: true),
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
                              Theme.of(context).splashColor,
                              Theme.of(context).unselectedWidgetColor,
                              // Theme.of(context).indicatorColor,
                              // Theme.of(context).dialogBackgroundColor,
                              // Theme.of(context).canvasColor,
                            ],
                            primaryXAxis: CategoryAxis(
                              // visibleMinimum: 1,
                              majorGridLines: const MajorGridLines(width: 0),
                              labelPlacement: LabelPlacement.onTicks,
                            ),
                            primaryYAxis: NumericAxis(
                              axisLine: const AxisLine(width: 0),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              majorTickLines: const MajorTickLines(size: 0),
                            ),
                            // primaryYAxis: CategoryAxis(labelStyle: TextStyle(fontSize: 12)),
                            series: generatepHSeries(phData ??
                                [
                                  ChartData(1, [0, 0, 0, 0])
                                ]),
                            tooltipBehavior: TooltipBehavior(enable: true),
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
