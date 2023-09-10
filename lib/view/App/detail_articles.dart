import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:iotanic_app_dev/controller/wordpress_controller.dart';

class DetailArticles extends StatefulWidget {
  const DetailArticles({super.key});

  @override
  State<DetailArticles> createState() => _DetailArticlesState();
}

class _DetailArticlesState extends State<DetailArticles> {
  WordpressController wordpressC = WordpressController();
  late final data = Get.arguments;
  var img = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    Map<String, dynamic> image = await wordpressC.getImage(data['featured_media']);

    setState(() {
      img = image['url'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    String html = data['content']['rendered'];
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Text(
                '${data['title']['rendered']}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    'IoTanic Authors | ',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    'Technology',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                margin: const EdgeInsets.symmetric(vertical: 10),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  img,
                  width: screenWidth,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
                margin: const EdgeInsets.symmetric(vertical: 10),
                clipBehavior: Clip.antiAlias,
                child: HtmlWidget(
                  html,
                  // onTapUrl: (p0) {
                  //   return FutureOr();
                  // },
                  textStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                // child: Image(
                //   image: AssetImage('public/assets/img/artikel.png'),
                //   width: screenWidth,
                //   fit: BoxFit.cover,
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
