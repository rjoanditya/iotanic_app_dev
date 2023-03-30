import 'package:flutter/material.dart';

class Articles extends StatelessWidget {
  const Articles({super.key});

  @override
  Widget build(BuildContext context) {
    List categories = [
      'All',
      'Agriculture',
      'Fertilizer',
      'Diseases',
      'Market',
    ];

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
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                'Headlines',
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
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
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                margin: const EdgeInsets.all(10),
                clipBehavior: Clip.antiAlias,
                child: Image(
                  image: const AssetImage('public/assets/img/artikel.png'),
                  width: screenWidth * 0.85,
                  fit: BoxFit.cover,
                ),
              ),
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
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Icon(
                      Icons.watch_later_outlined,
                      size: 13,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    // width: screenWidth * 0.75,
                    child: Text(
                      '4h ago',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: 35,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
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
                          children: List.generate(categories.length, (index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 7),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide.none,
                                  ),
                                  primary: Theme.of(context).highlightColor,
                                  onPrimary: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {},
                                child: Text('${categories[index]}'),
                              ),
                            );
                          }),
                        ),
                      );
                    }),
              ),
              SizedBox(
                width: screenWidth * 0.9,
                height: screenHeight - 100,
                child: Wrap(
                  children: List.generate(categories.length, (index) {
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
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            height: screenHeight * 0.1525,
                            width: screenWidth * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Agriculture',
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.8,
                                          child: Text(
                                            'Padi Rojolele Varietas Premium dari Delanggu, Klaten',
                                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.35,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                Icons.date_range_rounded,
                                                size: 12,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                              Text(
                                                '15 Mar 2023',
                                                style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Icon(
                                                Icons.comment_rounded,
                                                size: 12,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                              Text(
                                                '23',
                                                style: TextStyle(
                                                  color: Theme.of(context).primaryColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  width: screenWidth * 0.15,
                                  height: screenWidth * 0.15,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: const Image(
                                    image: AssetImage('public/assets/img/artikel.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                //
              ),
            ],
          ),
        ),
      ),
    );
  }
}
