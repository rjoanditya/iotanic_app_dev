import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iotanic_app_dev/controller/land_controller.dart';
// import 'package:flutter/services.dart';
import '../../constant.dart';
import 'package:flutter_map/flutter_map.dart'; //
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final MapController _mapController = MapController();
  TextEditingController searchController = TextEditingController();
  LatLng point = LatLng(-7.5624974, 110.8557175);

  LatLng currentLocation = LatLng(0, 0);

  void performGeocoding(String query) async {
    List<Location> locations = await locationFromAddress(query);
    if (locations.isNotEmpty) {
      Location location = locations.first;
      currentLocation = LatLng(location.latitude, location.longitude);
      _mapController.move(currentLocation, 15); // Move the map to the geocoded location

      setState(() {});
    } else {
      // Handle the case where no locations are found
      print('error');
    }
  }

  // double _rotation = 0;
  // String _scanBarcode = 'Unknown';
  // var search_text = '';

  Land landC = Get.put(Land());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight,
                    width: screenWidth,
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        onTap: (position, y) async {
                          point = y;
                          setState(() {});
                        },
                        // onPositionChanged: (position, hasGesture) {
                        //   setState(() {});
                        // },
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
                                builder: (context) {
                                  return Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.red,
                                    size: 50,
                                    shadows: [BoxShadow(color: Colors.black.withOpacity(.5), spreadRadius: 5, blurRadius: 7, offset: const Offset(0, 4))],
                                  );
                                })
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Form(
                        child: TextFormField(
                      controller: searchController,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      obscureText: false,
                      autofocus: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.edit_location_alt_outlined),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () async {
                            String query = searchController.text.trim();
                            if (query.isNotEmpty) {
                              performGeocoding(query);
                            }
                          },
                        ),
                        hintText: 'Cari Lokasi',
                        hintStyle: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor.withOpacity(.8)),
                        filled: true,
                        fillColor: Theme.of(context).highlightColor.withOpacity(.9),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 25,
                        ),
                      ),
                    )),
                  ),
                  Container(
                    height: screenHeight * 0.9,
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ButtonTheme(
                      child: ElevatedButton(
                        onPressed: () {
                          landC.lat.text = point.latitude.toString();
                          landC.lon.text = point.longitude.toString();

                          setState(() {});
                          Get.back(result: [point.latitude, point.longitude]);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.375, vertical: 23),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            )),
                        child: const Text(
                          "Simpan",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 120),
          // width: 50,
          // height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              maximumSize: Size(60, 60),
              minimumSize: Size(60, 60),
              backgroundColor: Colors.white,
              shape: CircleBorder(),
            ),
            onPressed: () {
              _mapController.move(point, 15);
            },
            child: Center(
              child: Icon(
                Icons.location_searching_rounded,
                color: Theme.of(context).canvasColor,
              ),
            ),
          )),
    );
  }
}
