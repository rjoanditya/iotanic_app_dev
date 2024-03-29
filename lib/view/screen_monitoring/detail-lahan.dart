import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:iotanic_app_dev/controller/variety.dart';
// import 'package:intl/intl.dart';
import 'package:iotanic_app_dev/controller/measurement_controller.dart';
// import 'package:iotanic_app_dev/view/screen_monitoring/chart-detail.dart';
import 'package:iotanic_app_dev/view/screen_monitoring/detail-varietas.dart';
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

class DetailLahan extends StatefulWidget {
  const DetailLahan({super.key});

  @override
  State<DetailLahan> createState() => _DetailLahanState();
}

class _DetailLahanState extends State<DetailLahan> {
  List<ChartData>? chartData;
  var data = Get.arguments;
  User user = Get.put(User());
  Land landC = Get.put(Land());

  @override
  void initState() {
    super.initState();
    // fetchData(); // Call the function to fetch the data here
  }

  // Future<void> fetchData() async {
  //   final List<ChartData> chart = await landC.getRecordsByLandId(data['id']);
  //   setState(() {
  //     chartData = chart; // Assign the fetched data to the chartData variable
  //   });
  //   chartData ??= [
  //     ChartData(1, [0, 0, 0, 0]),
  //     // ChartData(2, [15, 27, 27, 27]),
  //     // ChartData(3, [27, 26, 25, 25]),
  //     // ChartData(4, [37, 31, 33, 35]),
  //     // ChartData(5, [36, 36, 36, 36]),
  //   ];
  //   {}
  // }

  @override
  Widget build(BuildContext context) {
    Measurement measureC = Get.put(Measurement());
    VarietyController varietyC = Get.put(VarietyController());
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final List legendItem = ['Nitrogen', 'Phospat', 'Potasium', 'pH'];

    List<SplineSeries> generateSplineSeries(List<ChartData> chartData) {
      List<SplineSeries> splines = [];
      for (int i = 0; i < legendItem.length; i++) {
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
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Pilih Komoditas'),
        onPressed: () async {
          dynamic variety = await VarietyController.getVariety();

          // measureC.createMeasurement(context, data['id'], data['variety']['id']);
          AlertDialog alert = AlertDialog(
            backgroundColor: Theme.of(context).primaryColorDark,
            title: Text(
              'Daftar Komoditas',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(variety.length, (index) {
                  print(variety[index]);
                  return GestureDetector(
                    onTap: () async {
                      await measureC.createMeasurement(context, data['id'], variety[index]['id']);
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          width: screenWidth * 0.8,
                          height: screenWidth * 0.145,
                          decoration: BoxDecoration(
                            // color: Colors.amber,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                              child: Text(
                            '${variety[index]['name']}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ))),
                    ),
                  );
                }),
              ),
            ),
          );
          // ignore: use_build_context_synchronously
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        },
        icon: Icon(Icons.add),
        // child: Icon(Icons.add),
        tooltip: 'Tambah',
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
          child: Text(
            '${data['name']}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
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
                      padding: const EdgeInsets.all(20),
                      width: screenWidth * 0.85,
                      height: screenHeight * 0.2,
                      child: WeatherScreen(),
                    ),
                  ),
                  // Card(
                  //   // color: Color.fromARGB(255, 239, 246, 255),
                  //   margin: EdgeInsets.symmetric(vertical: 15),
                  //   color: Theme.of(context).cardColor,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(24),
                  //   ),
                  //   // clipBehavior: Clip.hardEdge,
                  //   elevation: 5,
                  //   shadowColor: Colors.black26,
                  //   child: Container(
                  //     padding: EdgeInsets.all(10),
                  //     width: screenWidth * 0.85,
                  //     height: screenHeight * 0.4,
                  //     child: Container(
                  //       width: screenWidth,
                  //       child: Column(children: [
                  //         Flexible(
                  //           flex: 1,
                  //           child: Container(
                  //             margin: EdgeInsets.only(right: 10),
                  //             width: screenWidth,
                  //             height: 20,
                  //             child: InkWell(
                  //               onTap: () async {
                  //                 Get.to(const ChartDetail(), arguments: data);
                  //               },
                  //               child: Text(
                  //                 'Selengkapnya',
                  //                 style: TextStyle(
                  //                   color: Theme.of(context).splashColor,
                  //                   fontWeight: FontWeight.w600,
                  //                   fontSize: 12,
                  //                 ),
                  //                 textAlign: TextAlign.end,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Flexible(
                  //           flex: 10,
                  //           child: Container(
                  //             child: SfCartesianChart(
                  //               legend: Legend(
                  //                 isVisible: true,
                  //                 position: LegendPosition.bottom,
                  //                 textStyle: TextStyle(
                  //                   color: Theme.of(context).primaryColor.withOpacity(.2),
                  //                   fontSize: 10,
                  //                 ),
                  //               ),
                  //               palette: <Color>[
                  //                 Theme.of(context).canvasColor,
                  //                 Theme.of(context).unselectedWidgetColor,
                  //                 Theme.of(context).indicatorColor,
                  //                 Theme.of(context).dialogBackgroundColor,
                  //               ],
                  //               primaryXAxis: CategoryAxis(
                  //                 labelStyle: const TextStyle(
                  //                   fontSize: 10,
                  //                 ),
                  //                 majorGridLines: MajorGridLines(width: 0.2),
                  //                 majorTickLines: MajorTickLines(width: 0.2),
                  //                 minorTickLines: MinorTickLines(width: 0.2),
                  //                 minorGridLines: MinorGridLines(width: 0.2),
                  //                 // borderWidth: 0.2,
                  //                 maximumLabels: 5,
                  //               ),
                  //               primaryYAxis: CategoryAxis(
                  //                 labelStyle: const TextStyle(
                  //                   fontSize: 10,
                  //                 ),
                  //                 maximumLabels: 1,
                  //                 majorGridLines: MajorGridLines(width: 0.2),
                  //                 majorTickLines: MajorTickLines(width: 0.2),
                  //                 minorTickLines: MinorTickLines(width: 0.2),
                  //                 minorGridLines: MinorGridLines(width: 0.2),
                  //               ),
                  //               // primaryYAxis: CategoryAxis(labelStyle: TextStyle(fontSize: 12)),
                  //               series: generateSplineSeries(
                  //                 chartData ??
                  //                     [
                  //                       ChartData(1, [0, 0, 0, 0])
                  //                     ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ]),
                  //     ),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: screenWidth,
                        // height: screenHeight * 0.1,
                        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                        child: Text(
                          'Komoditas Tanaman',
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
                      future: measureC.getVarietiesByLandId(data['id']),
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        if (snapshot.hasError) {
                          return Text('$snapshot.error');
                        } else if (snapshot.hasData && snapshot.data! != null) {
                          return Column(
                            children: List.generate(
                                snapshot.data!.length,
                                (index) => GestureDetector(
                                      onTap: () async {
                                        Get.to(const DetailVarietas(), arguments: {'data': data, 'variety': snapshot.data![index]});
                                        // dynamic measureByVarietyId = await measureC.getMeasurementsByVarietyId('${snapshot.data![index]['id']}');
                                      },
                                      child: Card(
                                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        elevation: 5,
                                        shadowColor: Colors.black26,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(20),
                                          width: screenWidth * 0.85,
                                          height: screenHeight * 0.15,
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.symmetric(horizontal: 15),
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
                                                        '${snapshot.data![index]['name']}',
                                                        style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
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
                                    )),
                          );
                        } else if (snapshot.data == []) {
                          return SizedBox(
                            height: screenHeight * 0.15,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Tidak ada data. Silahkan tambahkan pengukuran',
                                style: TextStyle(color: Theme.of(context).primaryColor),
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
                      }),
                  // FutureBuilder(
                  //   future: measureC.getMeasurements('${data['id']}'),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasError) {
                  //       return Text('$snapshot.error');
                  //     } else if (snapshot.hasData && snapshot.data!['data'] != null) {
                  //       return Column(
                  //         children: List.generate(
                  //           snapshot.data!['count'],
                  //           (index) => GestureDetector(
                  //             onTap: () {
                  //               var id = snapshot.data!;
                  //               measureC.getMeasurementById(id['data'][index]['id']);
                  //             },
                  //             child: Card(
                  //               margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  //               elevation: 5,
                  //               shadowColor: Colors.black26,
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(24),
                  //               ),
                  //               child: Container(
                  //                 padding: EdgeInsets.all(20),
                  //                 width: screenWidth * 0.85,
                  //                 height: screenHeight * 0.15,
                  //                 child: Row(
                  //                   children: [
                  //                     Container(
                  //                       // margin: const EdgeInsets.symmetric(horizontal: 15),
                  //                       width: screenWidth * 0.13,
                  //                       // height: screenWidth * 0.145,
                  //                       decoration: BoxDecoration(
                  //                         // color: Colors.amber,
                  //                         borderRadius: BorderRadius.circular(50),
                  //                       ),
                  //                       child: Icon(
                  //                         Icons.grass,
                  //                         size: screenWidth * 0.06,
                  //                         color: Theme.of(context).primaryColor,
                  //                       ),
                  //                     ),
                  //                     Expanded(
                  //                       flex: 2,
                  //                       child: Padding(
                  //                         padding: const EdgeInsets.all(10),
                  //                         child: Column(
                  //                           mainAxisAlignment: MainAxisAlignment.center,
                  //                           crossAxisAlignment: CrossAxisAlignment.start,
                  //                           children: [
                  //                             Text(
                  //                               // data lahan disini
                  //                               'MID-${snapshot.data!['data'][index]['id']}',
                  //                               style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                  //                             ),
                  //                             Text(
                  //                               DateFormat("EEE, d MMM yyyy HH:mm:ss").format(DateTime.parse(snapshot.data!['data'][index]['created_at'].toString())),
                  //                               style: TextStyle(
                  //                                 color: Theme.of(context).primaryColor,
                  //                                 fontWeight: FontWeight.w400,
                  //                                 fontSize: 12,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       width: screenWidth * 0.15,
                  //                       child: Icon(
                  //                         Icons.arrow_forward_ios_rounded,
                  //                         color: Theme.of(context).primaryColor,
                  //                         size: 15,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     } else if (snapshot.hasData && snapshot.data!['data'] == null) {
                  //       return SizedBox(
                  //         height: screenHeight * 0.15,
                  //         child: const Center(
                  //             child: Padding(
                  //           padding: EdgeInsets.symmetric(horizontal: 20),
                  //           child: Text(
                  //             'Tidak ada data. Silahkan tambahkan pengukuran',
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         )),
                  //       );
                  //     }
                  //     // By default, show a loading spinner.
                  //     return SizedBox(
                  //       width: 50,
                  //       height: 50,
                  //       child: LinearProgressIndicator(
                  //         color: Theme.of(context).primaryColorDark,
                  //         backgroundColor: Theme.of(context).splashColor,
                  //       ),
                  //     );
                  //   },
                  // )
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
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    // print('weather: $data');

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<Map<String, dynamic>>(
      future: fetchWeather(data['location']['lat'], data['location']['lon']),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if (snapshot.hasData) {
          Map<String, dynamic>? mapResponse = snapshot.data;
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
                      'Cuaca Saat Ini',
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
                    'Desk',
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
                    'Kelembaban',
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
                      'Jarak Pandang',
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
                      'Angin',
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
                    Get.to(const Forecast(), arguments: data);
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
    );
  }
}
