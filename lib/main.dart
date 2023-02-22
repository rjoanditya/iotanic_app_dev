import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'view/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
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
    highlightColor: Colors.white70,
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
  );

  Image logoLight = const Image(image: AssetImage('public/assets/img/logo.png'));
  Image logoDark = const Image(image: AssetImage('public/assets/img/logow.png'));

  Future<void> swapTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_selectedTheme == dark) {
      _selectedTheme = light;
      _selectedLogo = logoLight;
      prefs.setBool('isDarkTheme', false);
    } else {
      _selectedTheme = dark;
      _selectedLogo = logoDark;
      prefs.setBool('isDarkTheme', true);
    }
    // _selectedLogo = _selectedLogo == logoLight ? logoDark : logoLight;
    notifyListeners();
  }

  ThemeData get getThemes => _selectedTheme;
  Image get getLogo => _selectedLogo;

  ThemeProvider({isDarkMode = false}) {
    _selectedTheme = isDarkMode ? dark : light;
    _selectedLogo = isDarkMode ? logoDark : logoLight;
  }
}
