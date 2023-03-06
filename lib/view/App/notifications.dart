import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 75,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
            )
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight - 100,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 15,
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
                          height: 70,
                          width: screenWidth * 0.9,
                          margin: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Container(
                                width: screenWidth * 0.145,
                                height: screenWidth * 0.145,
                                decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(50)),
                              ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Someone Following You!',
                                        style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Pertanian',
                                        style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.07,
                                child: IconButton(
                                    iconSize: screenWidth * 0.05,
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Theme.of(context).primaryColor,
                                    )),
                              ),
                            ],
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
