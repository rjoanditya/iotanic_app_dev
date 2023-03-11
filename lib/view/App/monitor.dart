import 'package:flutter/material.dart';
import 'package:iotanic_app_dev/view/Form/add_field.dart';
import 'package:iotanic_app_dev/view/Pages_Monitoring/detail-lahan.dart';

enum _MenuValues {
  addField,
}

class Monitor extends StatelessWidget {
  const Monitor({super.key});
  @override
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
              fontSize: 20,
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
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DetailLahan()));
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
                                          'Lahan Pak Supriyadi ${index + 1}',
                                          style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          'Kamis, 12 Januari 2023',
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
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DetailLahan()));
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
                }),
          ),
        ),
      ),
    );
  }
}
