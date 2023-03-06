// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:iotanic_app_dev/view/App/articles.dart';
import 'package:iotanic_app_dev/view/App/community.dart';
import 'package:iotanic_app_dev/view/App/home.dart';
import 'package:iotanic_app_dev/view/App/monitor.dart';
import 'package:iotanic_app_dev/view/App/profile.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _app = [
      Home(),
      Monitor(),
      Community(),
      Articles(),
      Profile(),
    ];

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: _app.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 15,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navButton(0, _selectedIndex, Icons.home_rounded, "Home", screenWidth * 0.2),
              navButton(1, _selectedIndex, Icons.area_chart_rounded, "Monitor", screenWidth * 0.2),
              navButton(2, _selectedIndex, Icons.chat_rounded, "Forum", screenWidth * 0.2),
              navButton(3, _selectedIndex, Icons.list_rounded, "Article", screenWidth * 0.2),
              navButton(4, _selectedIndex, Icons.person, "Profil", screenWidth * 0.2),
            ],
          ),
        ),
      ),
    );
  }
  // Navbutton index

  Widget navButton(index, active, icon, label, screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: (index == active) ? Theme.of(context).primaryColorDark : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: (index == 4)
            ? BorderRadius.only(topLeft: Radius.circular(10))
            : (index == 0)
                ? BorderRadius.only(topRight: Radius.circular(10))
                : BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0)),
      ),
      width: screenWidth,
      // color: (index == active) ? HexColor("#002D3B") : Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              _onItemTapped(index);
            },
            child: Column(
              children: [
                Icon(
                  icon,
                  color: (active == index) ? Colors.white : Theme.of(context).primaryColor,
                ),
                Text(
                  (active == index) ? label : "",
                  style: TextStyle(fontSize: 12, color: (index == active) ? Colors.white : Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
