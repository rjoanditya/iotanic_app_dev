// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; //
import 'package:flutter_map/plugin_api.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:iotanic_app_dev/view/Pages_Monitoring/detail-records.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../constant.dart';
import '../../model/weather.dart';
import '../Form/add_measurement.dart';
import 'detail-records.dart';

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

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    LatLng point = LatLng(-7.4217141, 109.2345068);

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
            Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHeight * 0.325,
                      width: screenWidth * 0.9,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                            // urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(15),
                            // padding: EdgeInsets.symmetric(vertical: 15),
                            width: screenHeight * 0.1,
                            height: screenHeight * 0.1,
                            // color: Colors.amber,
                            child: IconButton(
                                onPressed: () async {
                                  List<Placemark> placemark = await placemarkFromCoordinates(7.566463, 110.8949131);
                                  print(placemark);
                                },
                                icon: Icon(
                                  Icons.location_searching,
                                  color: Theme.of(context).primaryColor,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            // padding: EdgeInsets.symmetric(vertical: 15),
                            width: screenHeight * 0.1,
                            height: screenHeight * 0.1,
                            // color: Colors.amber,
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.location_searching,
                                  color: Theme.of(context).primaryColor,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            // padding: EdgeInsets.symmetric(vertical: 15),
                            width: screenHeight * 0.1,
                            height: screenHeight * 0.1,
                            // color: Colors.amber,
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.location_searching,
                                  color: Theme.of(context).primaryColor,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.1,
                      color: Colors.amber,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.1,
                      color: Colors.amber,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.1,
                      color: Colors.amber,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.1,
                      color: Colors.amber,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
