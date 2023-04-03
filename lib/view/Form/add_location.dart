import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import '../../constant.dart';
import 'package:flutter_map/flutter_map.dart'; //
import 'package:flutter_map/plugin_api.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  late final MapController _mapController;
  double _rotation = 0;

  String _scanBarcode = 'Unknown';

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Pilih Lokasi',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight * 0.3,
                width: screenWidth,
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
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                ))
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  'Nearby Places',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor.withOpacity(.6),
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.5,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              height: 50,
                              width: 50,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Theme.of(context).highlightColor,
                              ),
                              child: Icon(
                                Icons.compost_rounded,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                            ),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kelompok Tani',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Cabeyan, Sukoharjo',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12,
                                    // fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
