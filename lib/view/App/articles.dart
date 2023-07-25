import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iotanic_app_dev/view/App/detail_articles.dart';
import 'package:iotanic_app_dev/view/search/search_input.dart';

import '../../controller/wordpress_controller.dart';

// import 'index.dart';

class Articles extends StatefulWidget {
  const Articles({super.key});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> with TickerProviderStateMixin {
  late final TabController _tabController;
  WordpressController wordpressC = WordpressController();
  List categories = [];
  bool isLoading = true;
  dynamic latest;

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    List<Map<String, dynamic>> articles = await wordpressC.getArticles();
    List<Map<String, dynamic>> latestArticle = await wordpressC.getLatestArticles();

    setState(() {
      categories = articles;
      latest = latestArticle[0];
      _tabController = TabController(length: categories.length, vsync: this);
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      return SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColorDark,
            backgroundColor: Theme.of(context).splashColor,
          ),
        ),
      );
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    DateTime date = DateTime.parse(latest['date'].replaceAll('T', ' ') + '.000000');
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
            // Container(
            //   margin: const EdgeInsets.only(left: 10),
            //   child: Text(
            //     '2 Juli 2023',
            //     style: TextStyle(
            //       color: Theme.of(context).primaryColor,
            //       fontSize: 14,
            //     ),
            //   ),
            // ),
          ],
        ),
        actions: [
          Container(
            // margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
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
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (BuildContext context) {
                //     return const SearchInput();
                //   }),
                // );
              },
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
          child: GestureDetector(
            onTap: () {
              wordpressC.getPost(latest['id']);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    '${latest['image']['url']}',
                    // width: screenWidth * 0.85,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  // width: screenWidth * 0.85,
                  child: Text(
                    '${latest['title']}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
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
                          DateFormat("d MMM yyyy").format(date),
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
                          '${latest['comment_length']}',
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
                                DateTime date = DateTime.parse(categories[index]['data'][e]['date'].replaceAll('T', ' ') + '.000000');
                                return GestureDetector(
                                  onTap: () async {
                                    return wordpressC.getPost(categories[index]['data'][e]['id']);
                                  },
                                  child: Container(
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
                                                  '${categories[index]['data'][e]['title']}',
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
                                                      DateFormat("d MMM yyyy").format(date),
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
                                                      '${categories[index]['data'][e]['comment_length']}',
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
                                        ('${categories[index]['data'][e]['image']['url']}' != '')
                                            ? Container(
                                                margin: const EdgeInsets.all(5),
                                                width: screenWidth * 0.15,
                                                height: screenWidth * 0.15,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                ),

                                                child: Image.network(
                                                  '${categories[index]['data'][e]['image']['url']}',
                                                  fit: BoxFit.cover,
                                                ),
                                                // CachedNetworkImage(
                                                //   imageUrl:
                                                //   "${categories[index]['data'][e]['image']['url]}"
                                                //   ),
                                                // ),
                                              )
                                            : Container(),
                                      ],
                                    ),
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
      ),
    );
  }
}
