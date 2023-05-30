import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iotanic_app_dev/view/Form/add_field.dart';
import 'package:iotanic_app_dev/view/screen_monitoring/detail-lahan.dart';

import '../../controller/land_controller.dart';
import '../../model/user.dart';

enum _MenuValues {
  addField,
}

class Monitor extends StatefulWidget {
  @override
  State<Monitor> createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  @override
  Land land = Land();

  User user = Get.put(User());

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              'Daftar Lahan',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
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
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                color: Theme.of(context).highlightColor,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: _MenuValues.addField,
                    child: Text('Tambah Lahan',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                        )),
                  )
                ],
                onSelected: (value) {
                  switch (value) {
                    case _MenuValues.addField:
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddField()));
                      break;
                  }
                },
              ),
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight - 175,
              child: const LandList(),
            ),
          ),
        ));
  }
}

class LandList extends StatelessWidget {
  const LandList({super.key});

  @override
  Widget build(BuildContext context) {
    Land land = Land();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: land.getLand(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('$snapshot.error');
          // }
          //else if (!snapshot.hasData) {
          //   return Center(
          //     child: Text('kosong'),
          //   );
        } else if (snapshot.hasData && snapshot.data!['data'] != null) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!['count'],
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    land.getLandById(snapshot.data!['data'][index]['id']);
                  },
                  child: Column(
                    children: [
                      Card(
                        margin: const EdgeInsets.all(5),
                        elevation: 5,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Container(
                          height: 100,
                          width: screenWidth * 0.9,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                width: screenWidth * 0.145,
                                height: screenWidth * 0.145,
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
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // data lahan disini
                                        '${snapshot.data!['data'][index]['name']}',
                                        style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                                      ),
                                      (snapshot.data!['data'][index]['updated_at'] == null)
                                          ? Text(
                                              '${snapshot.data!['data'][index]['created_at']}',
                                              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
                                            )
                                          : Text(
                                              '${snapshot.data!['data'][index]['updated_at']}',
                                              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.15,
                                child: IconButton(
                                    iconSize: screenWidth * 0.04,
                                    onPressed: () {
                                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailLahan(id: 'khj')));
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Theme.of(context).primaryColor,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        } else if (snapshot.hasData && snapshot.data!['data'] == null) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Tidak ada data. Silahkan tambahkan lahan klik tombol tiga titik atas',
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ));
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
