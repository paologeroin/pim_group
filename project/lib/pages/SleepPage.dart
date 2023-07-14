import 'package:flutter/material.dart';
import 'package:pim_group/widgets/sleepCharts.dart';
import '../models/entities/entities.dart';
import '../models/repo/app_repository.dart';
import 'package:provider/provider.dart';

class SleepPage extends StatelessWidget {
  SleepPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
