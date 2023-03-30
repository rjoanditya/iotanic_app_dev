import 'package:flutter/material.dart';
import 'package:iotanic_app_dev/view/screen_profile/themes.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Themes
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const Themes();
                  }),
                );
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Row(
                  children: [
                    Container(
                      width: screenWidth * 0.115,
                      height: screenWidth * 0.115,
                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5)), color: Theme.of(context).highlightColor),
                      child: IconButton(
                        icon: Icon(
                          Icons.palette_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const Themes();
                            }),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          'Theme',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 15,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const Themes();
                          }),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            // Notifications
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
              ),
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (BuildContext context) {
                //     return const PersonalData();
                //   }),
                // );
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Row(
                  children: [
                    Container(
                      width: screenWidth * 0.115,
                      height: screenWidth * 0.115,
                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5)), color: Theme.of(context).highlightColor),
                      child: IconButton(
                        icon: Icon(
                          Icons.notifications_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        onPressed: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(builder: (BuildContext context) {
                          //     return const PersonalData();
                          //   }),
                          // );
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          'Notifications',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 15,
                      ),
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (BuildContext context) {
                        //     return const PersonalData();
                        //   }),
                        // );
                      },
                    )
                  ],
                ),
              ),
            ),
            // About
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
              ),
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (BuildContext context) {
                //     return const PersonalData();
                //   }),
                // );
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Row(
                  children: [
                    Container(
                      width: screenWidth * 0.115,
                      height: screenWidth * 0.115,
                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5)), color: Theme.of(context).highlightColor),
                      child: IconButton(
                        icon: Icon(
                          Icons.info_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        onPressed: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(builder: (BuildContext context) {
                          //     return const PersonalData();
                          //   }),
                          // );
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          'About',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 15,
                      ),
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (BuildContext context) {
                        //     return const PersonalData();
                        //   }),
                        // );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
