import 'package:flutter/material.dart';
import 'package:iotanic_app_dev/view/App/notifications.dart';
import 'package:iotanic_app_dev/view/search/search_input.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import '../../main.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List carouselItems = [
      'public/assets/img/carousel1.png',
      'public/assets/img/carousel2.png',
      'public/assets/img/carousel3.png',
    ];

    List categoryName = [
      'Agriculture',
      'Fertilizer',
      'Market',
      'Technology',
    ];
    List categoryIcon = [
      Icons.agriculture_rounded,
      Icons.yard,
      Icons.store,
      Icons.app_settings_alt_rounded,
    ];

    List appsName = [
      'Kalkulator Pupuk',
      'Katalog Tanaman',
      'Katalog Penyakit',
      'Uji Tanah',
    ];
    List appsIcon = [
      Icons.calculate_rounded,
      Icons.compost,
      Icons.emoji_nature_rounded,
      Icons.barcode_reader,
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 75,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                'IOTANIC',
                style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 22, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            color: Theme.of(context).primaryColor,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return const SearchInput();
              }),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.notifications_none),
              color: Theme.of(context).primaryColor,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return const Notifications();
                }),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: screenWidth * 0.6,
            decoration: BoxDecoration(color: Theme.of(context).highlightColor.withOpacity(.5)),
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: screenHeight * 0.25,
                autoPlayInterval: const Duration(seconds: 8),
              ),
              items: [carouselItems[0], carouselItems[1], carouselItems[2]].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      // width: screenWidth,
                      height: screenHeight * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset('$i'),
                    );
                  },
                );
              }).toList(),
              carouselController: CarouselController(),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(25, 15, 0, 0),
            alignment: Alignment.topLeft,
            child: Text(
              'Kategori',
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 125,
            child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      AlertDialog alert = AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            // Icon(Icons.close_outlined),
                            Text("Fitur belum tersedia")
                          ],
                        ),
                      );
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0.2,
                                blurRadius: 3,
                                offset: Offset(0, 0),
                              )
                            ],
                          ),
                          height: 60,
                          width: 60,
                          // padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12.5),
                          child: Icon(
                            categoryIcon[index],
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: Text(
                            categoryName[index],
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //
                      ],
                    ),
                  );
                }),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
            alignment: Alignment.topLeft,
            child: Text(
              'Mini Apps',
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 150,
            child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      AlertDialog alert = AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            // Icon(Icons.close_outlined),
                            Text("Fitur belum tersedia")
                          ],
                        ),
                      );
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0.2,
                                blurRadius: 3,
                                offset: Offset(0, 0),
                              )
                            ],
                          ),
                          height: 60,
                          width: 60,
                          // padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12.5),
                          child: Icon(
                            appsIcon[index],
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          height: 50,
                          child: Text(
                            appsName[index],
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // Text(topic[index]),
                      ],
                    ),
                  );
                }),
          ),
        ]),
      )),
    );
  }
}
