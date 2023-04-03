// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart'; //
import 'package:flutter_map/plugin_api.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:iotanic_app_dev/view/screen_monitoring/detail-records.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../constant.dart';
import '../Form/add_measurement.dart';

enum _MenuValues {
  addMeasurement,
}

class DetailMeasurements extends StatefulWidget {
  const DetailMeasurements({super.key});

  @override
  State<DetailMeasurements> createState() => _DetailMeasurementsState();
}

// final LatLng london = LatLng(51.5, -0.09);
// final LatLng paris = LatLng(48.8566, 2.3522);
// final LatLng dublin = LatLng(53.3498, -6.2603);

class _DetailMeasurementsState extends State<DetailMeasurements> {
  late final MapController _mapController;
  double _rotation = 0;

  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    LatLng point = LatLng(-7.711168, 110.935754);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Theme.of(context).canvasColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text(
                'Measurements #5',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text(
                'Lahan Pak Supriyadi #1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
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
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHeight * 0.25,
                      width: screenWidth * 0.8,
                      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Theme.of(context).dialogBackgroundColor, width: 5, strokeAlign: BorderSide.strokeAlignOutside),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: FlutterMap(
                        options: MapOptions(
                          onTap: (x, y) async {
                            List<Placemark> placemark = await placemarkFromCoordinates(7.566463, 110.8949131);
                            print(placemark);
                            setState(() {
                              point = y;
                            });
                          },
                          center: point,
                          zoom: 15,
                          minZoom: 5,
                          maxZoom: 18,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: ENDPOINT_MAPBOX,
                            userAgentPackageName: 'com.example.app',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                  width: 50,
                                  height: 50,
                                  point: point,
                                  builder: (context) => Icon(
                                        Icons.location_on,
                                        color: Theme.of(context).splashColor,
                                        size: 30,
                                        shadows: [BoxShadow(color: Colors.black.withOpacity(.5), spreadRadius: 5, blurRadius: 7, offset: Offset(0, 4))],
                                      ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.black26,
                        color: Theme.of(context).highlightColor,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.sensor_window_rounded,
                                  color: Colors.red,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Disconnected',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      // Container(
                                      //   width: 20,
                                      //   height: 11,
                                      //   margin: const EdgeInsets.only(left: 5),
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.red,
                                      //     borderRadius: BorderRadius.circular(3),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  Text(
                                    'Linked Devices Please!',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: screenWidth,
                      child: Text(
                        'Records',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        shadowColor: Colors.black26,
                        child: SizedBox(
                          height: screenHeight * 0.275,
                          child: DataTable(
                            columns: <DataColumn>[
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    '#',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'N',
                                    style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'P',
                                    style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'K',
                                    style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'pH',
                                    style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ],
                            rows: <DataRow>[
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                                          return DetailRecords();
                                        })));
                                      },
                                      child: Text('#1', style: TextStyle(color: Theme.of(context).splashColor)))),
                                  DataCell(Text('192', style: TextStyle(color: Theme.of(context).primaryColor))),
                                  DataCell(Text('185', style: TextStyle(color: Theme.of(context).primaryColor))),
                                  DataCell(Text('130', style: TextStyle(color: Theme.of(context).primaryColor))),
                                  DataCell(Text('5.6', style: TextStyle(color: Theme.of(context).primaryColor))),
                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                                          return DetailRecords();
                                        })));
                                      },
                                      child: Text('#2', style: TextStyle(color: Theme.of(context).splashColor)))),
                                  DataCell(Text('192', style: TextStyle(color: Theme.of(context).primaryColor))),
                                  DataCell(Text('185', style: TextStyle(color: Theme.of(context).primaryColor))),
                                  DataCell(Text('130', style: TextStyle(color: Theme.of(context).primaryColor))),
                                  DataCell(Text('5.6', style: TextStyle(color: Theme.of(context).primaryColor))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 65,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          scanBarcode();
        },
        label: const Text(
          'Linked Devices',
          style: TextStyle(letterSpacing: 0.1),
        ),
        icon: const Icon(Icons.qr_code_2_rounded),
      ),
    );
  }
}
