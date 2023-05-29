import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_flutter/flutter.dart' as charts; // ????
import 'package:pim_group/widgets/custom_plot.dart';
import '../models/sleep/sleepDB.dart';
import '../models/sleep/sleep_provider.dart';

// Creation of a StatefulWidget for the sleep page:
// it requires two classes (at least).
// Below there is the StatefulWidget class that creates an instance of the Widget itself.
class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  State<SleepPage> createState() => _SleepPageState();
}

// And then there is a State class that manages the state of the StatefulWidget
class _SleepPageState extends State<SleepPage> {
  @override
  Widget build(BuildContext context) {
    // calling the provider responsible for the sleep data
    return ChangeNotifierProvider<SleepProvider>(
        create: (context) => SleepProvider(),
        builder: (context, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 109, 230, 69),
              elevation: 1,
              title: const Text('Sleep Data', textAlign: TextAlign.center),
              centerTitle: true,
              leading: IconButton(
                padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                onPressed: () async {
                  // DA MODIFICARE DOPO CHE CI HA SPIEGATO COME FETCHARE I DATI
                  // PurpleAirService purpleAirService = Provider.of<PurpleAirService>(context, listen: false);
                  //       Preferences prefs = Provider.of<Preferences>(context, listen: false);
                  //       bool auth = false;
                  //       String? apiKey = prefs.purpleAirXApiKey;
                  //       if (apiKey != null) {
                  //         auth = await purpleAirService.getAuth(apiKey);
                  //       }
                  //       if (auth) {
                  //         // Purple Air data fetch
                  //         Map<String, dynamic> response = await purpleAirService
                  //             .getData(ServerStrings.sensorIdxMortise);
                  //         print(response["sensor"]["pm10.0"]);
                  //       }
                },
                icon: const Icon(
                  MdiIcons.downloadCircle,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // List of various parameters measured during the last night, made up so far
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Sleep Duration'),
                          trailing: Text('8h 30m'),
                        ),
                        ListTile(
                          title: Text('Time to Fall Asleep'),
                          trailing: Text('15 minutes'),
                        ),
                        ListTile(
                          title: Text('Awakenings'),
                          trailing: Text('2 times'),
                        ),
                      ],
                    ),
                  ),
                  // I make a Row widget to create navigation between days
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            // TO BE IMPLEMENTED (?)
                            // setState(() {
                            //   selectedDayIndex--;
                            //   currentDate = currentDate.subtract(Duration(days: 1));
                            // });
                            DateTime day = Provider.of<SleepProvider>(context,
                                    listen: false)
                                .dateOfSleep;
                            Provider.of<SleepProvider>(context, listen: false)
                                .getDataOfDay(
                                    day.subtract(const Duration(days: 1)));
                          }),
                      // TO BE IMPLEMENTED (?)
                      // Text(
                      //   '${_getFormattedDate(currentDate)}',
                      //   style: TextStyle(
                      //   fontSize: 24,
                      //   fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      Consumer<SleepProvider>(
                          builder: (context, value, child) => Text(
                              DateFormat('dd MMMM yyyy')
                                  .format(value.dateOfSleep))),
                      IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            // TO BE IMPLEMENTED (?)
                            // setState(() {
                            //   selectedDayIndex++;
                            //   currentDate = currentDate.add(Duration(days: 1));
                            // });
                            DateTime day = Provider.of<SleepProvider>(context,
                                    listen: false)
                                .dateOfSleep;
                            Provider.of<SleepProvider>(context, listen: false)
                                .getDataOfDay(day.add(const Duration(days: 1)));
                          })
                    ],
                  ),
                  // TO BE IMPLEMENTED (?)
                  // SleepCycleChart(
                  //   sleepDataList[selectedDayIndex],
                  // ),
                  /*  Consumer<SleepProvider>(
                  builder: (context, value, child) =>
                      CustomPlot(data: _parseData(value.durationValue))
                  )*/
                ]))));
  }

  List<Map<String, dynamic>> _parseData(List<sleepDuration> data) {
    return data
        .map(
          (e) => {
            'date': DateFormat('HH:mm').format(e.timestamp),
            'points': e.durationValue
          },
        )
        .toList();
  }
  // TO BE IMPLEMENTED (?)
  // String _getFormattedDate(DateTime date) {
  //   return '${date.day}/${date.month}/${date.year}';
  // }
} //_SleepPageState

// Here it's defined a class dedicated to the sleep graph: sleep duration is represented
// on the x-axis, and sleep stages are represented on the y-axis.
// To be fixed with the provider and DB
class SleepCycleChart extends StatelessWidget {
  final SleepData sleepData;

  SleepCycleChart(this.sleepData);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Serve per scorrimento??
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sleep Cycle',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 200,
            child: charts.LineChart(
              _createChartData(),
              animate: true,
              domainAxis: charts.NumericAxisSpec(
                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                  zeroBound: false,
                  desiredTickCount: 6,
                ),
                renderSpec: charts.SmallTickRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    fontSize: 12,
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              primaryMeasureAxis: charts.NumericAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // In the '_createChartData()' method, I used a variable 'x' to keep track of the position
  // on the x-axis as I iterate through the sleep stages.
  // Increment the value of 'x' with the duration of each sleep stage to correctly position
  // the points in the chart.
  List<charts.Series<SleepStageData, double>> _createChartData() {
    final data = sleepData.sleepStages;
    double x = 0;

    return [
      charts.Series<SleepStageData, double>(
        id: 'SleepStage',
        domainFn: (SleepStageData sleepStageData, _) =>
            x += sleepStageData.duration,
        measureFn: (SleepStageData sleepStageData, _) =>
            sleepStageData.stageIndex,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        data: data,
        labelAccessorFn: (SleepStageData sleepStageData, _) =>
            '${sleepStageData.stage}',
      ),
    ];
  }
}

class SleepData {
  final DateTime date;
  final List<SleepStageData> sleepStages;

  SleepData(this.date, this.sleepStages);
}

// The 'stageIndex' field in the 'SleepStageData' is used to assign a numerical value to each stage of sleep.
// This value is used as a measure in the y-axis.
class SleepStageData {
  final String stage;
  // final int stageIndex;
  final double duration;

  SleepStageData(this.stage, this.duration);

  get stageIndex => null;
  // SleepStageData(this.stage, this.stageIndex, this.duration);
}
