import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;

import 'view/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(ChangeNotifierProvider(
    child: const MyApp(),
    create: (BuildContext context) => ThemeProvider(
      isDarkMode: prefs.getBool("isDarkTheme") ?? false,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'IoTanic | Precision Farming',
          theme: themeProvider.getThemes,
          home: const Splash(),
        );
      },
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  // ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  // themeProvider.swapTheme();
  // print(themes.getLogo);
  bool isDarkMode = false;

  late ThemeData _selectedTheme;
  late Image _selectedLogo;

  // final textTheme = Theme.of(context).textTheme;

  ThemeData light = ThemeData(
    // primaryColor: const Color(0XFF002D3B),
    primarySwatch: const MaterialColor(
      0XFF002D3B,
      <int, Color>{
        50: Color(0XFF002D3B),
        100: Color(0XFF002D3B),
        200: Color(0XFF002D3B),
        300: Color(0XFF002D3B),
        400: Color(0XFF002D3B),
        500: Color(0XFF002D3B),
        600: Color(0XFF002D3B),
        700: Color(0XFF002D3B),
        800: Color(0XFF002D3B),
        900: Color(0XFF002D3B),
      },
    ),
    scaffoldBackgroundColor: const Color(0XFFFCFCFC),
    fontFamily: 'Poppins',
    primaryColor: Colors.black,
    highlightColor: const Color(0XFFF5F6FA),
    splashColor: const Color(0XFF617BF3),
    canvasColor: const Color(0XFF002D3B),
    unselectedWidgetColor: const Color(0XFF05754C),
    indicatorColor: const Color(0XFF759AA2),
    dialogBackgroundColor: const Color(0XFF8BBEAB),
    secondaryHeaderColor: const Color(0XFFFFFFFF),
  );
  ThemeData dark = ThemeData(
    // primaryColor: const Color(0XFF05754C),
    primarySwatch: const MaterialColor(0XFF05754C, <int, Color>{
      50: Color(0XFF05754C),
      100: Color(0XFF05754C),
      200: Color(0XFF05754C),
      300: Color(0XFF05754C),
      400: Color(0XFF05754C),
      500: Color(0XFF05754C),
      600: Color(0XFF05754C),
      700: Color(0XFF05754C),
      800: Color(0XFF05754C),
      900: Color(0XFF05754C),
    }),
    scaffoldBackgroundColor: const Color(0XFF15171B),
    fontFamily: 'Poppins',
    primaryColor: Colors.white70,
    highlightColor: const Color(0XFF21242A),
    splashColor: const Color(0XFF617BF3),
    cardColor: const Color(0XFF21242A),
    canvasColor: const Color(0XFF002D3B),
    unselectedWidgetColor: const Color(0XFF05754C),
    indicatorColor: const Color(0XFF759AA2),
    dialogBackgroundColor: const Color(0XFF8BBEAB),
    secondaryHeaderColor: const Color(0XFFFFFFFF),
  );

  Image logoLight = const Image(image: AssetImage('public/assets/img/logo.png'));
  Image logoDark = const Image(image: AssetImage('public/assets/img/logow.png'));

  Future<void> swapTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_selectedTheme == dark) {
      _selectedTheme = light;
      _selectedLogo = logoLight;
      isDarkMode = false;
      prefs.setBool('isDarkTheme', false);
    } else {
      _selectedTheme = dark;
      _selectedLogo = logoDark;
      isDarkMode = true;
      prefs.setBool('isDarkTheme', true);
    }
    // _selectedLogo = _selectedLogo == logoLight ? logoDark : logoLight;
    notifyListeners();
  }

  Future<void> swapLightTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedTheme = light;
    isDarkMode = false;
    prefs.setBool('isDarkTheme', false);

    notifyListeners();
  }

  Future<void> swapDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedTheme = dark;
    isDarkMode = true;
    prefs.setBool('isDarkTheme', true);

    notifyListeners();
  }

  ThemeData get getThemes => _selectedTheme;
  Image get getLogo => _selectedLogo;

  ThemeProvider({isDarkMode = false}) {
    _selectedTheme = isDarkMode ? dark : light;
    _selectedLogo = isDarkMode ? logoDark : logoLight;
  }
}

dynamic chatDB = [
  {
    'forum_id': 'id1',
    'content': [
      {
        'user_id': 'adasda',
        'message': 'lorem',
        'attachment': '',
        'timestamp': 123123,
      }
    ],
  },
  {
    'forum_id': 'id2',
    'content': [
      {
        'user_id': 'bcasck',
        'message': 'lorem',
        'attachment': 'img/adasda.jpg',
        'timestamp': 123123,
      }
    ],
  }
];
