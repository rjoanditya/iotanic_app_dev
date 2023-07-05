import 'package:flutter/material.dart';
import 'package:iotanic_app_dev/view/App/detail_articles.dart';

import 'index.dart';

class Articles extends StatefulWidget {
  const Articles({super.key});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> with TickerProviderStateMixin {
  late final TabController _tabController;
  List categories = [
    {
      'category_name': 'Latest',
      'data': [
        'Customer Feedback Over Intuition - Lean Startup',
        'Pertanian Presisi untuk Keberlanjutan Pertanian Indonesia',
        // 'artikel latest 3',
        // 'artikel latest 4',
      ]
    },
    {
      'category_name': 'Agriculture',
      'data': [
        'artikel Agriculture 1',
        'artikel Agriculture 2',
        // 'artikel Agriculture 3',
        // 'artikel Agriculture 4',
      ]
    },
    {
      'category_name': 'Fertilizer',
      'data': [
        'artikel Fertilizer 1',
        'artikel Fertilizer 2',
        'artikel Fertilizer 3',
        // 'artikel Fertilizer 4',
      ]
    },
    {
      'category_name': 'Diseases',
      'data': [
        'artikel Diseases 1',
        'artikel Diseases 2',
        'Padi Rojolele mengalamani kenaikan disease 3',
        'artikel Diseases 4',
        'artikel Diseases 5',
      ]
    },
    {
      'category_name': 'Market',
      'data': [
        'artikel Market 1',
        // 'artikel Market 2',
        // 'artikel Market 3',
        // 'artikel Market 4',
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                'Artikel',
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                '2 Juli 2023',
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
            // margin: const EdgeInsets.only(right: 10),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const DetailArticles();
                    }),
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  clipBehavior: Clip.antiAlias,
                  child: Image(
                    image: const AssetImage('public/assets/img/artikel.png'),
                    // width: screenWidth * 0.85,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const DetailArticles();
                    }),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  // width: screenWidth * 0.85,
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
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      // margin: const EdgeInsets.only(left: 30),
                      child: Icon(
                        Icons.date_range_rounded,
                        size: 13,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      // width: screenWidth * 0.75,
                      child: Text(
                        '27 Mar 2023',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.comment_rounded,
                        size: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        '23',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  width: screenWidth * 0.9,
                  child: TabBar(
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                    unselectedLabelColor: Theme.of(context).primaryColor,
                    indicatorWeight: 0,
                    automaticIndicatorColorAdjustment: true,
                    indicatorPadding: const EdgeInsets.symmetric(vertical: 5),
                    indicator: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(30),
                      shape: BoxShape.rectangle,
                    ),
                    controller: _tabController,
                    tabs: List.generate(
                        categories.length,
                        (index) => Tab(
                              text: '${categories[index]['category_name']}',
                            )),
                  )),
              SizedBox(
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                // color: Colors.green,
                width: screenWidth * 0.9,
                height: screenHeight * .67,
                child: TabBarView(
                  controller: _tabController,
                  children: List.generate(
                    categories.length,
                    (index) {
                      List articles = categories[index]['data'];
                      return SingleChildScrollView(
                        child: Column(
                          // scrollDirection: Axis.vertical,
                          children: List.generate(
                            articles.length,
                            (e) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                height: screenHeight * 0.125,
                                width: screenWidth * 0.9,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${categories[index]['category_name']}',
                                            style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.8,
                                            child: Text(
                                              '${categories[index]['data'][e]}',
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                              overflow: TextOverflow.ellipsis,
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
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
