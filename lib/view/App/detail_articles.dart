import 'package:flutter/material.dart';

class DetailArticles extends StatelessWidget {
  const DetailArticles({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        // actions: [
        //   Container(
        //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        //     child: Text(
        //       'Articles',
        //       style: TextStyle(
        //         fontSize: 16,
        //         fontWeight: FontWeight.w600,
        //         color: Theme.of(context).primaryColor,
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Text(
                'Customer Feedback Over Intuition - Lean Startup',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Row(
                children: [
                  Text('IoTanic admin |'),
                  Text('Technology'),
                ],
              ),
              Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                margin: const EdgeInsets.symmetric(vertical: 10),
                clipBehavior: Clip.antiAlias,
                child: Image(
                  image: const AssetImage('public/assets/img/artikel.png'),
                  width: screenWidth,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus nec venenatis justo. Pellentesque sed ultrices metus, feugiat ullamcorper erat. Nullam vitae tellus nec ante',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
