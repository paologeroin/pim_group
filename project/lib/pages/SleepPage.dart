import 'package:flutter/material.dart';
import 'package:pim_group/widgets/sleepCharts.dart';
import '../models/entities/entities.dart';
import '../models/repo/app_repository.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pim_group/services/impact.dart';

// lista di oggetti in modo che la creiamo da 4 elementi o da 5 elementi a seocnda delle necessità
List<SummaryData> datigrafico = [];



class SleepPage extends StatelessWidget {
  SleepPage({Key? key}) : super(key: key);


  @override
  
Widget build(BuildContext context) {

 for (int i = 0; i <deep.length; i++) {
  // definisco dati del grafico
datigrafico.add(SummaryData(days[i],deep[i],wake[i],light[i],rem[i]));
 }
 print('dati grafico ${datigrafico}');

  return Scaffold(
    body: Center(
        child: Container(
          child: SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(),
            primaryYAxis: CategoryAxis(title: AxisTitle(text: 'minutes')),
            title: ChartTitle(text: 'Sleep data'),
           legend: Legend(isVisible: true),
            series: <ChartSeries> [
              
               StackedColumnSeries <SummaryData, String>(
                // Bind data source
                name:'deep',
                dataSource:  datigrafico,
               
                xValueMapper: (SummaryData data, _) => data.days,
                yValueMapper: (SummaryData data, _) => data.deep,
              ),
              StackedColumnSeries <SummaryData, String>(
                // Bind data source
                name:'wake',
                dataSource:  datigrafico,
               
                xValueMapper: (SummaryData data, _) => data.days,
                yValueMapper: (SummaryData data, _) => data.wake,
              ),
              StackedColumnSeries <SummaryData, String>(
                // Bind data source
                name:'light',
                dataSource:  datigrafico,
               
                xValueMapper: (SummaryData data, _) => data.days,
                yValueMapper: (SummaryData data, _) => data.light,
              ),
              StackedColumnSeries <SummaryData, String>(
                // Bind data source
                name:'rem',
                dataSource:  datigrafico,
               
                xValueMapper: (SummaryData data, _) => data.days,
                yValueMapper: (SummaryData data, _) => data.rem,
              )
            ]
          )
        )
      )
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

      
      
      /*
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Consumer<AppDatabaseRepository>(
          builder: (context, dbr, child) {
            return FutureBuilder<List<Sleep>>(
              future: dbr.findAllSleeps(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final sleepData = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: const Text(
                          'How did you sleep last night?',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('Sleep Duration'),
                              trailing: Text('${((sleepData.last.duration)!/3600).toInt()} hours'),
                            ),
                            ListTile(
                              title: Text('Time Awake'),
                              trailing: Text('${sleepData.last.minutesAwake} minutes'),
                            ),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child: SleepChartWidget(sleepData),
                      // ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
*/