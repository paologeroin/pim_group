import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pim_group/models/db_sleep.dart';
import 'package:pim_group/services/impact.dart';
import 'package:pim_group/services/sleepData.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pim_group/widgets/custom_plot.dart';
import '../models/entities/entities.dart';
import '../models/repo/app_repository.dart';
import '../models/sleep/sleep_provider.dart';

// DA SISTEMARE TUTTA UNA VOLTA RISOLTO L'IMPACT
// MA SARÀ STATELESS O STATEFULL???

// // // Creation of a StatefulWidget for the sleep page:
// // // it requires two classes (at least).
// // // Below there is the StatefulWidget class that creates an instance of the Widget itself.
// // class SleepPage extends StatefulWidget {
// //   const SleepPage({super.key});

// //   @override
// //   State<SleepPage> createState() => _SleepState();
// // }

// // // And then there is a State class that manages the state of the StatefulWidget
// // class _SleepState extends State<SleepPage> {

class SleepPage extends StatelessWidget {
  const SleepPage({Key? key}) : super(key: key);

  //   // Access the data from SleepProvider
  //   // and build your UI based on the provider's data

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
          return FutureBuilder(
            initialData: null,
            //future: dbr.findSleepbyDate("${DateTime.now().subtract(const Duration(days: 1)).year}-0${DateTime.now().subtract(const Duration(days: 1)).month}-0${DateTime.now(). subtract(const Duration(days: 1)).day}"),
            future: dbr.findAllSleeps(),
            builder: (context, snapshot) {
              if (snapshot.hasData){
                final data = snapshot.data as List<Sleep>;
                //DateTime showDate = DateTime.now().subtract(const Duration(days: 1));
                String durationHour = (((data[data.length - 1].duration)!.toDouble())/3600).toString();
                String timeFallAsleep = data[data.length - 1].minutesToFallAsleep.toString(); // già in minuti
               // String remDuration = data[data.length - 1].levels.toString(); //capire come accedere a levels->summary->rem->duration
                //String awakenings =; da calcolare
                //  print(data[data.length-1].date);
                
              return Container(
                child: Column(
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
                    // List of various parameters measured during the last night
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
                        // Consumer<AppDatabaseRepository>(
                        // builder: (context, value, child) =>
                        Text(DateFormat('dd MMMM yyyy').format(dbr.showDate),
                        ),
                        //),
                        IconButton(
                          icon: const Icon(Icons.navigate_next),
                          onPressed: () {
                            DateTime day = dbr.showDate;
                            dbr.getDataOfDay(day.add(const Duration(days: 1)));
                          },
                        ),
                      ],
                    ),
                    //grafico
                    // Consumer<HomeProvider>(
                    // builder: (context, value, child) =>
                    // CustomPlot(data: _parseData(value.exposure)))
                  ],
                ),
              );
                //questa parte di codice era per gestire il fatto dei dati nulli
                } else {
                  return Container(
                        padding: EdgeInsets.all(16),
                        child: const Text(
                          'Can\'t read the data of todai :(',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  );
                }//else
            });
        }
      )
  )
  ); //Consumer e builder
} //Widget
} //StatelessWidget

// List<Map<String, dynamic>> _parseData(List<Levels> data) {
//   return data
//       .map(
//         (e) => {'level': e.levelName, 'time': e.minutes},
//       )
//       .toList();
// }