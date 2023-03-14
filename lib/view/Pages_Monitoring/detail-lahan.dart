// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:iotanic_app_dev/view/Pages_Monitoring/detail-records.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/weather.dart';
import '../Form/add_measurement.dart';
import 'detail-measurements.dart';
import 'detail-records.dart';

enum _MenuValues {
  addMeasurement,
}

class DetailLahan extends StatefulWidget {
  const DetailLahan({super.key});

  @override
  State<DetailLahan> createState() => _DetailLahanState();
}

class _DetailLahanState extends State<DetailLahan> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final List<ChartData> chartData = [
      ChartData(1, [29, 29, 28, 28]),
      ChartData(2, [15, 27, 27, 27]),
      ChartData(3, [27, 26, 25, 25]),
      ChartData(4, [37, 31, 33, 35]),
      ChartData(5, [36, 36, 36, 36]),
    ];
    final List legendItem = ['Nitrogen', 'Phospat', 'Potasium', 'pH'];

    List<SplineSeries> generateSplineSeries(List<ChartData> chartData) {
      List<SplineSeries> splines = [];
      for (int i = 0; i < chartData.first.y!.length; i++) {
        splines.add(
          SplineSeries<ChartData, String>(
            legendItemText: legendItem[i],
            dataSource: chartData,
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
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).canvasColor,
        title: Container(
          margin: const EdgeInsets.only(left: 5),
          child: const Text(
            'Lahan Pak Supriyadi #1',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: PopupMenuButton<_MenuValues>(
              elevation: 3,
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
              color: Theme.of(context).highlightColor,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: _MenuValues.addMeasurement,
                  child: Text('Tambah Pengukuran',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                      )),
                )
              ],
              onSelected: (value) {
                switch (value) {
                  case _MenuValues.addMeasurement:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddMeasurement()));
                    break;
                }
              },
            ),
          )
        ],
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
                    margin: EdgeInsets.symmetric(vertical: 15),
                    color: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    // clipBehavior: Clip.hardEdge,
                    elevation: 5,
                    shadowColor: Colors.black26,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: screenWidth * 0.85,
                      height: screenHeight * 0.2,
                      child: const WeatherScreen(),
                    ),
                  ),
                  Card(
                    // color: Color.fromARGB(255, 239, 246, 255),
                    margin: EdgeInsets.symmetric(vertical: 15),
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
                                onTap: () {},
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
                                  labelStyle: const TextStyle(
                                    fontSize: 10,
                                  ),
                                  majorGridLines: MajorGridLines(width: 0.2),
                                  majorTickLines: MajorTickLines(width: 0.2),
                                  minorTickLines: MinorTickLines(width: 0.2),
                                  minorGridLines: MinorGridLines(width: 0.2),
                                  // borderWidth: 0.2,
                                  maximumLabels: 5,
                                ),
                                primaryYAxis: CategoryAxis(
                                  labelStyle: const TextStyle(
                                    fontSize: 10,
                                  ),
                                  maximumLabels: 1,
                                  majorGridLines: MajorGridLines(width: 0.2),
                                  majorTickLines: MajorTickLines(width: 0.2),
                                  minorTickLines: MinorTickLines(width: 0.2),
                                  minorGridLines: MinorGridLines(width: 0.2),
                                ),
                                // primaryYAxis: CategoryAxis(labelStyle: TextStyle(fontSize: 12)),
                                series: generateSplineSeries(chartData),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.1,
                    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          elevation: 5,
                          shadowColor: Colors.black26,
                          child: SizedBox(
                            width: screenWidth * 0.175,
                            height: screenWidth * 0.175,
                            child: Icon(
                              Icons.safety_check,
                              color: Theme.of(context).primaryColor,
                              size: screenWidth * 0.065,
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          shadowColor: Colors.black26,
                          child: SizedBox(
                            width: screenWidth * 0.175,
                            height: screenWidth * 0.175,
                            child: Icon(
                              Icons.access_alarm_rounded,
                              color: Theme.of(context).primaryColor,
                              size: screenWidth * 0.065,
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          shadowColor: Colors.black26,
                          child: SizedBox(
                            width: screenWidth * 0.175,
                            height: screenWidth * 0.175,
                            child: Icon(
                              Icons.baby_changing_station_outlined,
                              color: Theme.of(context).primaryColor,
                              size: screenWidth * 0.065,
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5,
                          shadowColor: Colors.black26,
                          child: SizedBox(
                            width: screenWidth * 0.175,
                            height: screenWidth * 0.175,
                            child: Icon(
                              Icons.kayaking_rounded,
                              color: Theme.of(context).primaryColor,
                              size: screenWidth * 0.065,
                            ),
                          ),
                        ),
                      ],
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
                          'Pengukuran Terakhir',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 30),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Lihat Semua',
                            style: TextStyle(
                              color: Theme.of(context).splashColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                        return DetailMeasurements();
                      })));
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 15),
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
                              width: screenWidth * 0.13,
                              // height: screenWidth * 0.145,
                              decoration: BoxDecoration(
                                // color: Colors.amber,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.grass,
                                size: screenWidth * 0.06,
                                color: Theme.of(context).primaryColor,
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
                                      'Pengukuran ke-5',
                                      style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Kamis, 12 Januari 2023',
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

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<Map<String, dynamic>>(
      future: fetchWeather('109.2345068', '-7.4217141'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if (snapshot.hasData) {
          Map<String, dynamic>? mapResponse = snapshot.data;
          // print(mapResponse!['wind']['speed']);
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: Text(
                      'Current Weather',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      // color: Colors.red,
                      width: 25,
                      height: 25,
                      child: Image.network("http://openweathermap.org/img/w/${mapResponse!['weather'][0]['icon']}.png"),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Text(
                      '${mapResponse['main']['feels_like']}°C',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Text(
                      '/ ${mapResponse['main']['temp']}°C',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ]),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    'Desc',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Text(
                    '${mapResponse['weather'][0]['description']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    'Humidity',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  // fit: FlexFit.tight,
                  child: Text(
                    '${mapResponse['main']['humidity']}%',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ]),
              Container(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Flexible(
                    flex: 2,
                    // fit: FlexFit.tight,
                    child: Text(
                      'Visibility',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Text(
                      '${mapResponse['visibility']} m',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Text(
                      'Winds',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Text(
                      '${mapResponse['wind']['speed']} m/s',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ]),
              ),
              Flexible(
                  child: SizedBox(
                // margin: EdgeInsets.only(right: 10),
                width: screenWidth,
                child: InkWell(
                  onTap: () {
                    // print(jsonEncode(snapshot.data.toString()));
                  },
                  child: Text(
                    'Lihat Detail',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).splashColor,
                    ),
                  ),
                ),
              ))
            ],
          );
        }

        // By default, show a loading spinner.
        return SizedBox(
          width: 50,
          height: 50,
          child: LinearProgressIndicator(
            color: Theme.of(context).primaryColorDark,
            backgroundColor: Theme.of(context).splashColor,
          ),
        );
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final List? y;
}
