// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:get/get.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
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
  // late StreamSubscription subscription;
  // late StreamSubscription internetSubscription;
  // bool hasInternet = false;
  ThemeProvider themes = ThemeProvider();

  // @override
  // void initState() {
  //   super.initState();
  //   subscription = Connectivity().onConnectivityChanged.listen(_showConnectivitySnackBar);
  // // internetSubscription = InternetConnectionChecker().onStatusChange.listen((status) {
  // //   final hasInternet = status == InternetConnectionStatus.connected;

  // });

  // setState(() => this.hasInternet = hasInternet);
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                const Image(image: AssetImage('public/assets/img/splash.png')),
                Container(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // void _showConnectivitySnackBar(ConnectivityResult result) {
  //   final hasInternet = result != ConnectivityResult.none;
  //   final message = hasInternet
  //       ? result == ConnectivityResult.mobile
  //           ? "you're connected to mobile network"
  //           : "You're connected to wifi network"
  //       : "You're not connected";

  //   final color = hasInternet ? Colors.green : Colors.red;

  //   _showSnackBar(context, message, color);
  // }

  // void _showSnackBar(context, String message, MaterialColor color) {
  //   Get.snackbar(
  //     'Alert!',
  //     message,
  //     colorText: Theme.of(context).primaryColor,
  //     borderColor: color,
  //   );
  //   Timer(Duration(seconds: 3), () {
  //     Get.to(SignIn());
  //   });
  // }
}
