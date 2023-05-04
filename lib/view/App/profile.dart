import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iotanic_app_dev/controller/auth_controller.dart';
import 'package:iotanic_app_dev/model/user.dart';
import 'package:iotanic_app_dev/view/screen_profile/faq.dart';
import 'package:iotanic_app_dev/view/screen_profile/personal-data.dart';
import 'package:iotanic_app_dev/view/screen_profile/settings.dart';

class Profile extends StatelessWidget {
  // const Profile({super.key});

  AuthController authcontroller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    User user = User();
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // profile name & photos
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              child: Row(children: [
                Container(
                  width: screenWidth * 0.175,
                  height: screenWidth * 0.175,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Image(
                    image: AssetImage('public/assets/img/joan.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        future: User.getUser('email'),
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data.toString(),
                            overflow: TextOverflow.ellipsis,
                            // maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        },
                      ),
                      FutureBuilder(
                        future: User.getUser('role'),
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ]),
            ),
            Divider(
              height: 1,
              thickness: 0.1,
              indent: 20,
              endIndent: 20,
              color: Theme.of(context).primaryColor,
            ),
            // personal data
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const PersonalData();
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
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const PersonalData();
                            }),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          'Personal Data',
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
                            return const PersonalData();
                          }),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            // settings
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const Settings();
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
                          Icons.settings,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const Settings();
                            }),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          'Settings',
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
                            return const Settings();
                          }),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            // E-Statement
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
              ),
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  children: [
                    Container(
                      width: screenWidth * 0.115,
                      height: screenWidth * 0.115,
                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5)), color: Theme.of(context).highlightColor),
                      child: IconButton(
                        icon: Icon(
                          Icons.file_present_sharp,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          'E-Statement',
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
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 0.1,
              indent: 20,
              endIndent: 20,
              color: Theme.of(context).primaryColor,
            ),
            // FAQ
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const FAQs();
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
                          Icons.help,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const FAQs();
                            }),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          'FAQs',
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
                            return const FAQs();
                          }),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            // handbook
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
              ),
              onPressed: () {},
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
                          Icons.book_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          'Our Handbook',
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
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            // Signout
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
              ),
              onPressed: () {
                authcontroller.signout();
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
                        icon: const Icon(
                          Icons.logout_rounded,
                          color: Colors.red,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: const Text(
                          'Sign Out',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 15,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            // Feedback
            Container(),
          ],
        ),
      )),
    );
  }
}
