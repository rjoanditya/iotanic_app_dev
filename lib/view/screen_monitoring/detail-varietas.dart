import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iotanic_app_dev/controller/measurement_controller.dart';
import 'package:iotanic_app_dev/view/screen_monitoring/chart-detail.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:iotanic_app_dev/view/screen_monitoring/forecast.dart';

import '../../model/user.dart';
import '../../model/weather.dart';
import '../../model/chartData.dart';
import '../../controller/land_controller.dart';
// import '../Form/add_measurement.dart';
// import 'detail-measurements.dart';

// enum _MenuValues {
//   addMeasurement,
// }

class DetailVarietas extends StatefulWidget {
  const DetailVarietas({super.key});

  @override
  State<DetailVarietas> createState() => _DetailVarietasState();
}

class _DetailVarietasState extends State<DetailVarietas> {
  List<ChartData>? chartData;
  var data = Get.arguments;
  // var recordData = landC.fetchRecordsByMeasurementId()
  User user = Get.put(User());
  Land landC = Get.put(Land());

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the function to fetch the data here
  }

  Future<void> fetchData() async {
    final List<ChartData> chart = await landC.getRecordsByLandId(data['data']['id'], data['variety']['id']);
    setState(() {
      chartData = chart; // Assign the fetched data to the chartData variable
    });
    chartData ??= [
      ChartData(1, [0, 0, 0, 0]),
      // ChartData(2, [15, 27, 27, 27]),
      // ChartData(3, [27, 26, 25, 25]),
      // ChartData(4, [37, 31, 33, 35]),
      // ChartData(5, [36, 36, 36, 36]),
    ];
    {}
  }

  @override
  Widget build(BuildContext context) {
    print('variety: ${data['variety']}');

    Measurement measureC = Get.put(Measurement());
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final List legendItem = ['Nitrogen', 'Fosfor', 'Kalium', 'pH'];

    List<SplineSeries> generateSplineSeries(List<ChartData> chartData) {
      List<SplineSeries> splines = [];
      for (int i = 0; i < legendItem.length; i++) {
        splines.add(
          SplineSeries<ChartData, String>(
            legendItemText: legendItem[i],
            name: legendItem[i],
            dataSource: chartData,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await measureC.createMeasurement(context, data['data']['id'], data['variety']['id']);
          print('tambah');
        },
        tooltip: 'Tambah',
        child: const Icon(Icons.add),
        // icon: Icon(Icons.add),
        // label: Text(
        //   'Tambah Pengukuran',
        //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        // ),
      ),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).canvasColor,
        title: Container(
          margin: const EdgeInsets.only(left: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data['data']['name']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${data['variety']['name']}',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        // actions: [
        //   Container(
        //     margin: const EdgeInsets.only(right: 10),
        //     child: PopupMenuButton<_MenuValues>(
        //       elevation: 3,
        //       icon: const Icon(
        //         Icons.more_vert_rounded,
        //         color: Colors.white,
        //       ),
        //       color: Theme.of(context).highlightColor,
        //       itemBuilder: (context) => [
        //         PopupMenuItem(
        //           value: _MenuValues.addMeasurement,
        //           child: Text('Tambah Pengukuran',
        //               style: TextStyle(
        //                 color: Theme.of(context).primaryColor,
        //                 fontSize: 14,
        //               )),
        //         )
        //       ],
        //       onSelected: (value) {
        //         switch (value) {
        //           case _MenuValues.addMeasurement:
        //             Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddMeasurement()));
        //             break;
        //         }
        //       },
        //     ),
        //   )
        // ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight * 0.18,
              decoration: BoxDecoration(
                color: Theme.of(context).unselectedWidgetColor,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.175,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
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
                      padding: EdgeInsets.all(10),
                      width: screenWidth * 0.85,
                      height: screenHeight * 0.4,
                      child: Container(
                        width: screenWidth,
                        child: Column(children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              width: screenWidth,
                              height: 20,
                              child: InkWell(
                                onTap: () async {
                                  Get.to(const ChartDetail(), arguments: data);
                                },
                                child: Text(
                                  'Selengkapnya',
                                  style: TextStyle(
                                    color: Theme.of(context).splashColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 10,
                            child: Container(
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
                                  Theme.of(context).canvasColor,
                                  Theme.of(context).unselectedWidgetColor,
                                  Theme.of(context).indicatorColor,
                                  Theme.of(context).dialogBackgroundColor,
                                ],

                                primaryXAxis: CategoryAxis(
                                  // isInversed: true,
                                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                                  labelPlacement: LabelPlacement.betweenTicks,
                                  // visibleMinimum: 1,
                                  visibleMaximum: 6,
                                  majorGridLines: const MajorGridLines(width: 0),
                                  // labelPlacement: LabelPlacement.onTicks,
                                ),
                                primaryYAxis: NumericAxis(
                                    // minimum: 30,
                                    // maximum: 80,

                                    axisLine: const AxisLine(width: 0),
                                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                                    // labelFormat: '{value} ppm',
                                    majorTickLines: const MajorTickLines(size: 0)),
                                // primaryYAxis: CategoryAxis(labelStyle: TextStyle(fontSize: 12)),
                                series: generateSplineSeries(
                                  chartData ??
                                      [
                                        ChartData(1, [0, 0, 0, 0])
                                      ],
                                ),
                                tooltipBehavior: TooltipBehavior(enable: true),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: screenWidth,
                        // height: screenHeight * 0.1,
                        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                        child: Text(
                          'Pengukuran',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future: measureC.getMeasurementsByVarietyId(data['variety']['id'], data['data']['id']),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('$snapshot.error');
                      } else if (snapshot.hasData && snapshot.data!['data'] != null) {
                        var i = 1;
                        return Column(
                          children: List.generate(
                            snapshot.data!['count'],
                            (index) => GestureDetector(
                              onTap: () {
                                var id = snapshot.data!;
                                print(id['data'][index]['id']);
                                measureC.getMeasurementById(id['data'][index]['id']);
                              },
                              child: Card(
                                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                elevation: 5,
                                shadowColor: Colors.black26,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: screenWidth * 0.85,
                                  height: screenHeight * 0.15,
                                  child: Row(
                                    children: [
                                      Container(
                                        // margin: const EdgeInsets.symmetric(horizontal: 15),
                                        // width: screenWidth * 0.13,
                                        // height: screenWidth * 0.145,
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          // color: Colors.amber,
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        // child: Icon(
                                        //   Icons.grass,
                                        //   size: screenWidth * 0.06,
                                        //   color: Theme.of(context).primaryColor,
                                        // ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${i++}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                                color: Theme.of(context).scaffoldBackgroundColor,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                // data lahan disini
                                                'MID-${snapshot.data!['data'][index]['id']}',
                                                style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                DateFormat("EEE, d MMM yyyy HH:mm:ss").format(DateTime.parse(snapshot.data!['data'][index]['updated_at'].toString())),
                                                style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.15,
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Theme.of(context).primaryColor,
                                          size: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasData && snapshot.data!['data'] == null) {
                        return SizedBox(
                          height: screenHeight * 0.15,
                          child: const Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Tidak ada data. Silahkan tambahkan pengukuran',
                              textAlign: TextAlign.center,
                            ),
                          )),
                        );
                      }
                      // By default, show a loading spinner.
                      return SizedBox(
                        width: screenWidth,
                        height: screenHeight,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColorDark,
                            backgroundColor: Theme.of(context).splashColor,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
