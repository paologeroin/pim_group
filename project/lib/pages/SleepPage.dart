import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pim_group/models/db_sleep.dart';
import 'package:pim_group/services/impact.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pim_group/widgets/custom_plot.dart';
import '../models/entities/entities.dart';
import '../models/sleep/sleep_provider.dart';

// // Creation of a StatefulWidget for the sleep page:
// // it requires two classes (at least).
// // Below there is the StatefulWidget class that creates an instance of the Widget itself.
// class SleepPage extends StatefulWidget {
//   const SleepPage({super.key});

//   @override
//   State<SleepPage> createState() => _SleepState();
// }

// // And then there is a State class that manages the state of the StatefulWidget
// class _SleepState extends State<SleepPage> {

class SleepPage extends StatelessWidget {
  const SleepPage({Key? key}) : super(key: key);

  // Access the data from SleepProvider
  // and build your UI based on the provider's data

  @override
  Widget build(BuildContext context) {
    return Consumer<SleepProvider>(builder: (context, sleepProvider, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 109, 230, 69),
            elevation: 1,
            title: const Text('Sleep Data', textAlign: TextAlign.center),
            centerTitle: true,
            leading: IconButton(
              padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
              onPressed: () async {},
              icon: const Icon(
                MdiIcons.downloadCircle,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          body: Padding(
              padding: EdgeInsets.all(8.0),
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
                    // List of various parameters measured during the last night
                    Card(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Consumer<SleepProvider>(
                            builder: (context, sleepProvider, child) {
                          Sleep? sleepData = sleepProvider
                              .getDataOfDay(DateTime.now()) as Sleep?;
                          int? awakenings = sleepProvider.awakeCount as int?;
                          if (sleepData != null) {
                            return ListView(
                              children: [
                                ListTile(
                                  title: Text('Sleep Duration'),
                                  trailing: Text('${sleepData.duration}'),
                                ),
                                ListTile(
                                  title: Text('Time to Fall Asleep'),
                                  trailing: Text(
                                      '${sleepData.minutesToFallAsleep} minutes'),
                                ),
                                ListTile(
                                    title: Text('Awakenings'),
                                    trailing: Text(
                                        '${awakenings}') //oppure sleepProvider.awakeCount e commento riga 69
                                    ),
                              ],
                            );
                          } else {
                            return ListView(
                              children: [
                                ListTile(
                                  title: Text('Sleep Duration'),
                                  trailing: Text('No entry today!'),
                                ),
                                ListTile(
                                  title: Text('Time to Fall Asleep'),
                                  trailing: Text('No entry today!'),
                                ),
                                ListTile(
                                    title: Text('Awakenings'),
                                    trailing: Text('No entry today!')),
                              ],
                            );
                          }
                        })),
                    // I make a Row widget to create navigation between days
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.navigate_before),
                            onPressed: () {
                              // here we use the access method to retrieve the Provider and use its values and methods
                              final sleepProvider = Provider.of<SleepProvider>(
                                  context,
                                  listen: false);
                              DateTime day = sleepProvider.dateOfSleep;
                              sleepProvider.getDataOfDay(
                                  day.subtract(const Duration(days: 1)));
                            }),
                        Consumer<SleepProvider>(
                            builder: (context, value, child) => Text(
                                DateFormat('dd MMMM yyyy')
                                    .format(value.dateOfSleep))),
                        IconButton(
                            icon: const Icon(Icons.navigate_next),
                            onPressed: () {
                              final sleepProvider = Provider.of<SleepProvider>(
                                  context,
                                  listen: false);
                              DateTime day = sleepProvider.dateOfSleep;
                              sleepProvider.getDataOfDay(
                                  day.add(const Duration(days: 1)));
                            })
                      ],
                    ),
                    // Da capire grafico perché dà errore il widget
                    // Consumer<SleepProvider>(
                    //   builder: (context, sleepProvider, child) {
                    //     List<Levels> data = sleepProvider.level; // Assumi che sleepLevels sia la lista dei livelli di sonno
                    //     return CustomPlot(data: _parseData(data));
                    //   },
                    // )
                  ]))); //Scaffold
    }); //Consumer e builder
  } //Widget
} //StatelessWidget

List<Map<String, dynamic>> _parseData(List<Levels> data) {
  return data
      .map(
        (e) => {'level': e.levelName, 'time': e.minutes},
      )
      .toList();
}
