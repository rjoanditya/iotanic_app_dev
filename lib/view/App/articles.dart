import 'package:flutter/material.dart';

class Articles extends StatelessWidget {
  const Articles({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 75,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'Headlines',
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'January 21, 2023',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_rounded,
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage('public/assets/img/artikel.png'),
                    width: screenWidth * 0.85,
                    fit: BoxFit.cover,
                  )),
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: screenWidth * 0.85,
                child: Text(
                  'Customer Feedback Over Intuition - Lean Startup',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                width: screenWidth * 0.85,
                child: Text(
                  '4h ago',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 20,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
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
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              height: 20,
                              width: screenWidth * 0.2,
                              decoration: BoxDecoration(color: Colors.red),
                              child: Text(
                                'Kategori',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                width: screenWidth * 0.9,
                height: screenHeight - 100,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.vertical,
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
                              height: 96,
                              width: screenWidth * 0.9,
                              margin: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Agriculture',
                                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.8,
                                            child: Text(
                                              'Padi Rojolele Varietas Premium dari Delanggu, Klaten',
                                              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.4,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Icon(
                                                  Icons.watch_later_outlined,
                                                  size: 15,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                                Text(
                                                  '14h ago',
                                                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
                                                ),
                                                Icon(
                                                  Icons.comment_rounded,
                                                  size: 15,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                                Text(
                                                  '23',
                                                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    width: screenWidth * 0.15,
                                    height: screenWidth * 0.15,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
