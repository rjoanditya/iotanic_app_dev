import 'package:flutter/material.dart';
import 'package:iotanic_app_dev/main.dart';
import 'package:provider/provider.dart';

class Themes extends StatefulWidget {
  const Themes({super.key});

  @override
  State<Themes> createState() => _ThemesState();
}

class _ThemesState extends State<Themes> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    ThemeProvider themes = Provider.of<ThemeProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Themes Mode',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Light Mode
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
              ),
              onPressed: () {
                themes.swapLightTheme();
                print(themes.isDarkMode);
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        themes.isDarkMode == true ? Icons.radio_button_off_rounded : Icons.radio_button_checked,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      onPressed: () {
                        themes.swapLightTheme();
                        print(themes.isDarkMode);
                      },
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Light Mode',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Dark Mode
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
              ),
              onPressed: () {
                themes.swapDarkTheme();
                print(themes.isDarkMode);
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        themes.isDarkMode == false ? Icons.radio_button_off_rounded : Icons.radio_button_checked,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      onPressed: () {
                        themes.swapDarkTheme();
                        print(themes.isDarkMode);
                      },
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Dark Mode',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
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
