import 'package:flutter/material.dart';
import 'package:iotanic_app_dev/view/App/notifications.dart';
import 'package:iotanic_app_dev/view/Search/search_input.dart';

// import '../../main.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 98,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                'Hi, Sonic',
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                'Selamat Datang di IOTANIC',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                ),
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
            decoration: BoxDecoration(color: Theme.of(context).highlightColor),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(25, 15, 0, 0),
            alignment: Alignment.topLeft,
            child: Text(
              'Trending',
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            height: 130,
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
                          height: 70,
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
                          width: 70,
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 15),
                          child: const Center(
                              // child: Image(image: AssetImage(icon[index])),
                              ),
                        ),
                        // Text(topic[index]),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
            alignment: Alignment.topLeft,
            child: Text(
              'Topik untuk Anda',
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            height: 130,
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
                          height: 70,
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
                          width: 70,
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(15),
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
