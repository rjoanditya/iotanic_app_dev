// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:iotanic_app_dev/main.dart';

import 'package:iotanic_app_dev/view/Auth/signin.dart';

class Splash extends StatefulWidget {
  final ThemeData? themeData;
  const Splash({Key? key, this.themeData}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  ThemeProvider themes = ThemeProvider();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(80),
                child: themes.getLogo,
              ),
            ),
            // navButtonSplash(context),
            Stack(
              children: [
                (screenHeight > screenWidth)
                    ? const Image(image: AssetImage('public/assets/img/splash.png'))
                    : Positioned(
                        top: 50,
                        // bottom: 30,
                        child: Container(
                            width: screenWidth,
                            height: screenHeight,
                            child: const Image(
                              image: AssetImage('public/assets/img/splash.png'),
                              fit: BoxFit.contain,
                            )),
                      ),
                (screenHeight > screenWidth)
                    ? Container(
                        height: screenWidth * 0.8,
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(screenWidth * 0.8, 30),
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            elevation: 1,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          ),
                          onPressed: () async {
                            bool result = await InternetConnectionChecker().hasConnection;
                            result == false
                                ? Get.snackbar(
                                    "Ups! Anda Sedang Offline",
                                    'Periksa Koneksi Internet Anda!',
                                    colorText: Theme.of(context).primaryColor,
                                    margin: const EdgeInsets.all(10),
                                  )
                                : Timer(const Duration(seconds: 1), () {
                                    Get.to(const SignIn());
                                  });
                          },
                          child: const Text(
                            "Get Started",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    : Container(
                        alignment: Alignment.bottomCenter,
                        // height: screenHeight * 0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(screenWidth * 0.4, 30),
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            elevation: 1,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                          ),
                          onPressed: () {},
                          child: Text('Get Started'),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
