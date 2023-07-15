import 'package:flutter/material.dart';
import '../models/entities/entities.dart';
import '../models/repo/app_repository.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pim_group/services/impact.dart';

List<SummaryData> datigrafico = [];

class SleepPage extends StatelessWidget {
  SleepPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < deep.length; i++) {
      datigrafico.add(SummaryData(days[i], deep[i], wake[i], light[i], rem[i]));
    }
    print('dati grafico ${datigrafico}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 194, 138, 243),
        elevation: 1,
        title: const Text('Sleep Data', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Consumer<AppDatabaseRepository>(
          builder: (context, dbr, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: const Text(
                    'How was your sleep last night?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FutureBuilder<List<Sleep>>(
                  future: dbr.findAllSleeps(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final dataSleep = snapshot.data as List<Sleep>;
                      String durationHour =
                          (((dataSleep[dataSleep.length - 1].duration)!
                                      .toDouble()) /
                                  3600)
                              .toString();
                      String minutesAsleep = (((dataSleep[dataSleep.length - 1]
                          .minutesAsleep)!.toDouble())/60)
                          .toStringAsFixed(1);
                      return Column(
                        children: [
                          Card(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text('Sleep Session Duration'),
                                  trailing: Text('$durationHour hours'),
                                ),
                                ListTile(
                                  title: Text('Actually Asleep'),
                                  trailing: Text('$minutesAsleep hours'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: CategoryAxis(title: AxisTitle(text: 'minutes')),
                  title: ChartTitle(text: 'Sleep Stages Summary'),
                  legend: Legend(isVisible: true),
                  series: <ChartSeries>[
                    StackedColumnSeries<SummaryData, String>(
                      name: 'deep',
                      dataSource: datigrafico,
                      xValueMapper: (SummaryData data, _) => data.days,
                      yValueMapper: (SummaryData data, _) => data.deep,
                    ),
                    StackedColumnSeries<SummaryData, String>(
                      name: 'wake',
                      dataSource: datigrafico,
                      xValueMapper: (SummaryData data, _) => data.days,
                      yValueMapper: (SummaryData data, _) => data.wake,
                    ),
                    StackedColumnSeries<SummaryData, String>(
                      name: 'light',
                      dataSource: datigrafico,
                      xValueMapper: (SummaryData data, _) => data.days,
                      yValueMapper: (SummaryData data, _) => data.light,
                    ),
                    StackedColumnSeries<SummaryData, String>(
                      name: 'rem',
                      dataSource: datigrafico,
                      xValueMapper: (SummaryData data, _) => data.days,
                      yValueMapper: (SummaryData data, _) => data.rem,
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class SummaryData {
  SummaryData(this.days, this.deep, this.wake, this.light, this.rem);
  final String days;
  final int deep;
  final int wake;
  final int light;
  final int rem;
}
