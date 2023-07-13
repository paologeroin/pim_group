import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pim_group/models/db_sleep.dart';
import 'package:pim_group/services/impact.dart';
import 'package:pim_group/services/sleepData.dart';
import 'package:pim_group/widgets/sleepChart.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pim_group/widgets/custom_plot.dart';
import '../models/entities/entities.dart';
import '../models/repo/app_repository.dart';
import '../models/sleep/sleep_provider.dart';


// Usiamo il custom plot dei tutor oppure vediamo di usare un altro modo per fare il grafico
// Siamo sicuri funzioni il database per i dati del sonno???

class SleepPage extends StatelessWidget {
  SleepPage({Key? key}) : super(key: key);

  List<Data> sleepChartData = [];

  // final SleepData sleepData = SleepData.fromJson({});

  @override
  Widget build(BuildContext context) {
    //     return Consumer<SleepProvider>(builder: (context, sleepProvider, child) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 194, 138, 243),
        elevation: 1,
        title: const Text('Sleep Data', textAlign: TextAlign.center),
        centerTitle: true,
        // Qui c'era il pulsante per aggiornare i dati
        // leading: IconButton(
        //   padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
        //   onPressed: () async {},
        //   icon: const Icon(
        //     MdiIcons.downloadCircle,
        //     size: 30,
        //     color: Colors.white,
        //   ),
        // ),
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
                    'How did you sleep last night?',
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
                      // Codice per creare le Card con i dati di sleepData
                      String durationHour = (((dataSleep[dataSleep.length - 1].duration)!.toDouble())/3600).toString();
                       String timeFallAsleep = dataSleep[dataSleep.length - 1].minutesToFallAsleep.toString(); // già in minuti
                      return Column(
                        children: [
                          Card(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Sleep Duration'),
                            trailing: Text('$durationHour hours'),
                          ),
                          ListTile(
                            title: Text('Time to Fall Asleep'),
                            trailing: Text(
                                '$timeFallAsleep minutes'),
                          ),
                          ListTile(
                            title: Text('REM state duration'),
                            trailing: Text('durata fase rem'),
                          ),
                          ListTile(
                            title: Text('Awakenings'),
                            trailing: Text('numero di risvegli'),
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
                ),//FutureBuilder per i dati del sonno
                FutureBuilder<List<Data>>(
                  future: dbr.findAllData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Data> sleepChartData = snapshot.data!;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.navigate_before),
                                onPressed: () {
                                  DateTime day = dbr.showDate;
                                  dbr.getDataOfDay(day.subtract(const Duration(days: 1)));
                                },
                              ),
                              Text(
                                DateFormat('dd MMMM yyyy').format(dbr.showDate),
                              ),
                              IconButton(
                                icon: const Icon(Icons.navigate_next),
                                onPressed: () {
                                  DateTime day = dbr.showDate;
                                  dbr.getDataOfDay(day.add(const Duration(days: 1)));
                                },
                              ),
                            ],
                          ),
                          SleepChart(sleepPhasesData: sleepChartData),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
