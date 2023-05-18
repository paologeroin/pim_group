import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pim_group/widgets/custom_plot.dart';
import '../models/sleep/sleepDB.dart';
import '../models/sleep/sleep_provider.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SleepProvider>(
      create: (context) => SleepProvider(),
      builder: (context, child) =>Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 109, 230, 69),
          elevation: 1,
          title: const Text('Sleep Data', textAlign: TextAlign.center),
          centerTitle: true,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
            onPressed: ()async {
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
        body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(children: [
              Text(
                "Your Sleep",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      //freccia di sinistra
                      icon: const Icon(Icons.navigate_before),
                      onPressed: () {}),
                  Text('Data di oggi'),
                  IconButton(
                      icon: const Icon(Icons.navigate_next), onPressed: () {})
                ],
              ),
              // Grafico a gradino (simile a ipnogramma) finto con dati a caso
              // Center(
              //     child: Container(
              //         //Initialize chart
              //         child: SfCartesianChart(
              //             // Chart title text
              //             title: ChartTitle(text: 'Last night sleep'),
              //             // Enables the legend
              //             legend: Legend(isVisible: false),
              //             // Initialize category axis
              //             primaryXAxis: CategoryAxis(),
              //             series: <ChartSeries>[
              //       // Initialize line series
              //       StepLineSeries<ChartData, int>(
              //         // Enables the tooltip for individual series
              //         enableTooltip: true,
              //         dataSource: [
              //           // Bind data source
              //           ChartData(21, 0),
              //           ChartData(23, -10),
              //           ChartData(1, 15),
              //           ChartData(3, -5),
              //           ChartData(5, 0),
              //           ChartData(7, 10),
              //           ChartData(9, -5),
              //         ],
              //         xValueMapper: (ChartData data, _) => data.x,
              //         yValueMapper: (ChartData data, _) => data.y,
              //         // Render the data label
              //         dataLabelSettings: DataLabelSettings(isVisible: true),
              //       )
              //     ])))
              // frecce e data
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: const Icon(Icons.navigate_before),
                      onPressed: () {
                        DateTime day =
                            Provider.of<SleepProvider>(context, listen: false)
                                .dateOfSleep;
                        Provider.of<SleepProvider>(context, listen: false)
                            .getDataOfDay(
                                day.subtract(const Duration(days: 1)));
                      }),
                  Consumer<SleepProvider>(
                      builder: (context, value, child) => Text(DateFormat('dd MMMM yyyy').format(value.dateOfSleep))),
                  IconButton(
                      icon: const Icon(Icons.navigate_next),
                      onPressed: () {
                        DateTime day =
                            Provider.of<SleepProvider>(context, listen: false)
                                .dateOfSleep;
                        Provider.of<SleepProvider>(context, listen: false)
                            .getDataOfDay(day.add(const Duration(days: 1)));
                      })
                ],
              ),
              Consumer<SleepProvider>(
                  builder: (context, value, child) =>
                      CustomPlot(data: _parseData(value.durationValue))
              )
            ]
          )
        )
      )
    );
  }


// Serve per grafico finto
// class ChartData {
//   ChartData(this.x, this.y);
//   final int x;
//   final double? y;
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
}