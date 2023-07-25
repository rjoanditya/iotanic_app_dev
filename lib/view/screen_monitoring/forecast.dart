import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/weather.dart';
import 'package:intl/intl.dart';

class Forecast extends StatefulWidget {
  const Forecast({super.key});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: FutureBuilder(
          future: fetchForecast(data['location']['lon'], data['location']['lat']),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.hasData) {
              Map<String, dynamic>? mapResponse = snapshot.data;
              return Text(
                snapshot.data?['city']['name'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
            return SizedBox(
              width: screenWidth,
              height: 50,
              child: LinearProgressIndicator(
                color: Theme.of(context).primaryColorDark,
                backgroundColor: Theme.of(context).splashColor,
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Text(
                  'Ramalan Cuaca',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              DataForecast(),
            ],
          ),
        ),
      ),
    );
  }
}

class DataForecast extends StatelessWidget {
  DataForecast({super.key});
  // const DataForecast({Key? key}) : super(key: key);
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: fetchForecast(data['location']['lon'], data['location']['lat']),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if (snapshot.hasData) {
          Map<String, dynamic>? mapResponse = snapshot.data;
          return Column(
            children: List.generate(
                mapResponse!['list'].length,
                (index) => SizedBox(
                      // margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: screenWidth,
                      height: screenHeight * 0.1,
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).highlightColor,
                            ),
                            child: Image.network(
                              "http://openweathermap.org/img/w/${mapResponse['list'][index]['weather'][0]['icon']}.png",
                              width: 5,
                              height: 5,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${mapResponse['list'][index]['weather'][0]['description']}'.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                  DateFormat('E, d MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(mapResponse['list'][index]['dt'] * 1000)),
                                  // '${mapResponse['list'][index]['dt']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                  DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(mapResponse['list'][index]['dt'] * 1000)),
                                  // '${mapResponse['list'][index]['dt']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: Text(
                                '${mapResponse['list'][index]['main']['feels_like']} °C',
                                style: TextStyle(color: Theme.of(context).primaryColor),
                              )),
                        ],
                      ),
                    )),
          );
        }
        return SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColorDark,
              backgroundColor: Theme.of(context).splashColor,
            ),
          ),
        );
      },
    );
  }
}
