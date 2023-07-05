import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart'; //
import 'package:flutter_map/plugin_api.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:iotanic_app_dev/controller/measurement_controller.dart';
import 'package:latlong2/latlong.dart';
import 'package:iotanic_app_dev/view/screen_monitoring/detail-records.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../constant.dart';
import '../Form/add_measurement.dart';
import '../../controller/record_controller.dart';

enum _MenuValues {
  addMeasurement,
}

class DetailMeasurements extends StatefulWidget {
  // const DetailMeasurements({super.key});

  @override
  State<DetailMeasurements> createState() => _DetailMeasurementsState();
}

class _DetailMeasurementsState extends State<DetailMeasurements> {
  var arguments = Get.arguments;

  late final MapController _mapController;
  late final bool isEmptyRecords = true;
  double _rotation = 0;
  late final data = arguments['data'];

  // String _scanBarcode = 'Unknown';
  void initState() {
    super.initState();
    _mapController = MapController();
  }

// scannnn
  Future<void> scanBarcode() async {
    Measurement measureC = Get.put(Measurement());

    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);

    setState(() {
      measureC.deviceId.text = barcodeScanResult;
    });
    measureC.connectToDevice(data['id']);
  }

  @override
  Widget build(BuildContext context) {
    List<LatLng> pointPolygons = [];
    // print('arguments : ${arguments['data']}');
    if (arguments['polygon'] != []) {
      pointPolygons = arguments['polygon'];
    }
    Measurement measureC = Get.put(Measurement());
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double lat = (data['land']['location']['lat'] is double) ? data['land']['location']['lat'] : double.parse(data['land']['location']['lat']);
    double lon = (data['land']['location']['lon'] is double) ? data['land']['location']['lon'] : double.parse(data['land']['location']['lon']);
    // print('Data: $data');

    LatLng point = LatLng(lat, lon);

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
              child: Text(
                "MID-${data['id']}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Text(
                "${data['land']['name']}",
                style: const TextStyle(
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
                        mapController: _mapController,
                        options: MapOptions(
                          center: point,
                          zoom: 16,
                          minZoom: 5,
                          maxZoom: 18,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: ENDPOINT_MAPBOX,
                            userAgentPackageName: 'com.example.app',
                          ),
                          CircleLayer(
                            circles: [CircleMarker(point: point, radius: 500, useRadiusInMeter: true, color: Colors.blueAccent.withOpacity(.15), borderStrokeWidth: 0.5)],
                          ),
                          PolygonLayer(
                            polygons: [Polygon(points: pointPolygons, isFilled: false, color: Theme.of(context).dialogBackgroundColor.withOpacity(.5))],
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
                                  shadows: [BoxShadow(color: Colors.black.withOpacity(.5), spreadRadius: 5, blurRadius: 7, offset: const Offset(0, 4))],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: (data['device'] == null || data['end'] != null)
                          ? Card(
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
                                      child: const Icon(
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
                                          ],
                                        ),
                                        Text(
                                          'Tautkan Perangkat!',
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
                            )
                          : Card(
                              elevation: 5,
                              shadowColor: Colors.black26,
                              color: Theme.of(context).highlightColor,
                              child: GestureDetector(
                                onTap: () {
                                  Get.snackbar('Tautan dilepaskan', 'Berhasil melepaskan tautan');
                                  measureC.disconnectToDevice(data['id'], data['device']['id']);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        margin: const EdgeInsets.only(right: 10),
                                        child: const Icon(
                                          Icons.sensor_window_rounded,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Connected',
                                                style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: screenWidth * 0.6,
                                            child: Text(
                                              'Tekan untuk Melepaskan Tautan',
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
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
                        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        shadowColor: Colors.black26,
                        child: SizedBox(
                          height: screenHeight * 0.275,
                          child: TableRecord(),
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
          'Tautkan Perangkat',
          style: TextStyle(letterSpacing: 0.1),
        ),
        icon: const Icon(Icons.qr_code_2_rounded),
      ),
    );
  }
}

class TableRecord extends StatefulWidget {
  TableRecord({super.key});

  @override
  State<TableRecord> createState() => _TableRecordState();
}

class _TableRecordState extends State<TableRecord> {
  var arguments = Get.arguments;
  late final data = arguments['records'];

  Record conditionController = Get.put(Record());

  @override
  Widget build(BuildContext context) {
    Record recordC = Get.put(Record());
    return SingleChildScrollView(
      child: DataTable(
          columns: <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'No',
                  style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'N',
                  style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'P',
                  style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'K',
                  style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'pH',
                  style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
          rows: List.generate(data.length, (row) {
            return DataRow(
              cells: <DataCell>[
                DataCell(InkWell(
                    onTap: () {
                      dynamic id = data[row]['_id'];
                      conditionController.getConditionId(id, arguments['data']);
                    },
                    child: Text('#${row + 1}', style: TextStyle(color: Theme.of(context).splashColor)))),
                DataCell(Text('${data[row]['condition']['nitrogen']}', style: TextStyle(color: Theme.of(context).primaryColor))),
                DataCell(Text('${data[row]['condition']['phosphorus']}', style: TextStyle(color: Theme.of(context).primaryColor))),
                DataCell(Text('${data[row]['condition']['potassium']}', style: TextStyle(color: Theme.of(context).primaryColor))),
                DataCell(Text('${data[row]['condition']['ph']}', style: TextStyle(color: Theme.of(context).primaryColor))),
              ],
            );
          })),
    );
  }
}
