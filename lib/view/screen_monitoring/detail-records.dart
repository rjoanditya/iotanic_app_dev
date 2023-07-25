import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/condition.dart';

class DetailRecords extends StatefulWidget {
  @override
  State<DetailRecords> createState() => _DetailRecordsState();
}

class _DetailRecordsState extends State<DetailRecords> {
  var data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(12),
              height: 10,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).dialogBackgroundColor.withOpacity(.5),
              ),
              child: Text(
                'IoTanic',
                style: TextStyle(
                  color: Theme.of(context).canvasColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Title
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'NPK PH',
                      style: TextStyle(
                        letterSpacing: 5,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      'Tanaman Anda',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nampak ',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Baik',
                          style: TextStyle(
                            color: Theme.of(context).unselectedWidgetColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          ' Hari Ini!',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // RadialBarChart
              dataCircularChart(context),
              // Table
              dataTable(context),
              // Button
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget dataTable(BuildContext context) {
  var arguments = Get.arguments;
  var data = arguments;

  dynamic ideal = {
    'n': data['data']['variety']['optimal_condition']['nitrogen'],
    'p': data['data']['variety']['optimal_condition']['phosphorus'],
    'k': data['data']['variety']['optimal_condition']['potassium'],
    'ph': data['data']['variety']['optimal_condition']['ph'],
  };

  dynamic records = {
    'n': data['condition']['condition']['nitrogen'],
    'p': data['condition']['condition']['phosphorus'],
    'k': data['condition']['condition']['potassium'],
    'ph': data['condition']['condition']['ph'],
  };
  dynamic scale = {
    'n': double.parse(((1 - ((ideal['n'] - records['n']).abs() / ideal['n'])) * 100).toStringAsFixed(1)),
    'p': double.parse(((1 - ((ideal['p'] - records['p']).abs() / ideal['p'])) * 100).toStringAsFixed(1)),
    'k': double.parse(((1 - ((ideal['k'] - records['k']).abs() / ideal['k'])) * 100).toStringAsFixed(1)),
    'ph': double.parse(((1 - ((ideal['ph'] - records['ph']).abs() / ideal['ph'])) * 100).toStringAsFixed(1)),
  };

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Nitrogen
        Container(
          margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Name
              Flexible(
                child: Row(
                  children: [
                    Container(
                      width: 18.6,
                      height: 18.6,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Text(
                      'Nitrogen',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              // Data
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  '${records['n']} ppm',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.end,
                ),
              ),
              // Value

              Flexible(
                child: Text(
                  '${scale['n']}%',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.end,
                ),
              ),
              (records['n'] > ideal['n']) ? const Icon(Icons.arrow_drop_up_rounded, color: Colors.green) : const Icon(Icons.arrow_drop_down_rounded, color: Colors.red),
            ],
          ),
        ),
        // Fosfor
        Container(
          margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Name
              Flexible(
                child: Row(
                  children: [
                    Container(
                      width: 18.6,
                      height: 18.6,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).unselectedWidgetColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Text(
                      'Fosfor',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              // Data

              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  '${records['p']} ppm',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.end,
                ),
              ),
              // Value

              Flexible(
                child: Text(
                  '${scale['p']}%',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.end,
                ),
              ),
              (records['p'] > ideal['p']) ? const Icon(Icons.arrow_drop_up_rounded, color: Colors.green) : const Icon(Icons.arrow_drop_down_rounded, color: Colors.red),
            ],
          ),
        ),
        // Potasium
        Container(
          margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Name
              Flexible(
                child: Row(
                  children: [
                    Container(
                      width: 18.6,
                      height: 18.6,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).indicatorColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Text(
                      'Potasium',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              // Data
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  '${records['k']} ppm',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.end,
                ),
              ),
              // Value

              Flexible(
                child: Text(
                  '${scale['k']}%',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.end,
                ),
              ),
              (records['k'] > ideal['k']) ? const Icon(Icons.arrow_drop_up_rounded, color: Colors.green) : const Icon(Icons.arrow_drop_down_rounded, color: Colors.red),
            ],
          ),
        ),
        // pH
        Container(
          margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Name
              Flexible(
                child: Row(
                  children: [
                    Container(
                      width: 18.6,
                      height: 18.6,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).dialogBackgroundColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Text(
                      'pH',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              // Data
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  '${records['ph']} ppm',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.end,
                ),
              ),
              // Value

              Flexible(
                child: Text(
                  '${scale['ph']}%',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.end,
                ),
              ),
              (records['ph'] > ideal['ph']) ? const Icon(Icons.arrow_drop_up_rounded, color: Colors.green) : const Icon(Icons.arrow_drop_down_rounded, color: Colors.red),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget dataCircularChart(BuildContext context) {
  var arguments = Get.arguments;
  var data = arguments;
  dynamic ideal = {
    'n': data['data']['variety']['optimal_condition']['nitrogen'],
    'p': data['data']['variety']['optimal_condition']['phosphorus'],
    'k': data['data']['variety']['optimal_condition']['potassium'],
    'ph': data['data']['variety']['optimal_condition']['ph'],
  };

  dynamic records = {
    'n': data['condition']['condition']['nitrogen'],
    'p': data['condition']['condition']['phosphorus'],
    'k': data['condition']['condition']['potassium'],
    'ph': data['condition']['condition']['ph'],
  };

  dynamic scale = {
    'n': double.parse(((1 - ((ideal['n'] - records['n']).abs() / ideal['n'])) * 100).toStringAsFixed(1)),
    'p': double.parse(((1 - ((ideal['p'] - records['p']).abs() / ideal['p'])) * 100).toStringAsFixed(1)),
    'k': double.parse(((1 - ((ideal['k'] - records['k']).abs() / ideal['k'])) * 100).toStringAsFixed(1)),
    'ph': double.parse(((1 - ((ideal['ph'] - records['ph']).abs() / ideal['ph'])) * 100).toStringAsFixed(1)),
  };

  NPKData nitrogen = NPKData('Nitrogen', scale['n'], '100%', Theme.of(context).canvasColor);
  NPKData phospat = NPKData('Fosfor', scale['p'], '100%', Theme.of(context).unselectedWidgetColor);
  NPKData potasium = NPKData('Potasium', scale['k'], '100%', Theme.of(context).indicatorColor);
  NPKData pH = NPKData('pH', scale['ph'], '100%', Theme.of(context).dialogBackgroundColor);
  List<NPKData> chartData = [pH, potasium, phospat, nitrogen];

  return SfCircularChart(
    legend: Legend(isVisible: true, isResponsive: true, position: LegendPosition.bottom, textStyle: TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.6))),
    series: <CircularSeries>[
      RadialBarSeries<NPKData, String>(
        dataSource: chartData,
        pointRadiusMapper: (NPKData data, _) => data.text,
        pointColorMapper: (NPKData data, _) => data.color,
        xValueMapper: (NPKData data, _) => data.xData,
        yValueMapper: (NPKData data, _) => data.yData,
        gap: '7%',
        radius: '100%',
        trackOpacity: 0.1,
        maximumValue: 100,
        useSeriesColor: true,
        cornerStyle: CornerStyle.bothCurve,
        dataLabelSettings: const DataLabelSettings(
          isVisible: false,
        ),
      )
    ],
  );
}

class NPKData {
  NPKData(this.xData, this.yData, this.text, this.color);
  final String xData;
  final num yData;
  final String? text;
  final Color color;
  // final HexColor? color;
}
