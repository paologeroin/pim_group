import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../models/entities/entities.dart';

class SleepChartWidget extends StatelessWidget {
  final List<Sleep> sleepData;

  SleepChartWidget(this.sleepData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    DurationChart(sleepData),
                    AwakeAsleepChart(sleepData),
                    EfficiencyChart(sleepData),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DurationChart extends StatelessWidget {
  final List<Sleep> sleepData;

  DurationChart(this.sleepData);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Sleep, String>> seriesList = [
      charts.Series<Sleep, String>(
        id: 'Duration',
        domainFn: (Sleep sleep, _) => sleep.dateOfSleep!,
        measureFn: (Sleep sleep, _) => sleep.duration!,
        data: sleepData,
      ),
    ];

    return Container(
      width: 300,
      child: charts.BarChart(
        seriesList,
        animate: true,
        vertical: false,
      ),
    );
  }
}

class AwakeAsleepChart extends StatelessWidget {
  final List<Sleep> sleepData;

  AwakeAsleepChart(this.sleepData);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Sleep, String>> seriesList = [
      charts.Series<Sleep, String>(
        id: 'Duration',
        domainFn: (Sleep sleep, _) => sleep.dateOfSleep!,
        measureFn: (Sleep sleep, _) => sleep.duration!,
        data: sleepData,
      ),
      charts.Series<Sleep, String>(
        id: 'Minutes Asleep',
        domainFn: (Sleep sleep, _) => sleep.dateOfSleep!,
        measureFn: (Sleep sleep, _) => sleep.minutesAsleep!.toDouble(),
        data: sleepData,
      ),
    ];

    return Container(
      width: 300,
      child: charts.BarChart(
        seriesList,
        animate: true,
        vertical: false,
      ),
    );
  }
}

class EfficiencyChart extends StatelessWidget {
  final List<Sleep> sleepData;

  EfficiencyChart(this.sleepData);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Sleep, String>> seriesList = [
      charts.Series<Sleep, String>(
        id: 'Efficiency',
        domainFn: (Sleep sleep, _) => sleep.dateOfSleep!,
        measureFn: (Sleep sleep, _) => sleep.efficiency!.toDouble(),
        data: sleepData,
      ),
    ];

    return Container(
      width: 300,
      height: 300, // Imposta una dimensione fissa per il grafico
      child: charts.LineChart(
        seriesList.cast<charts.Series<dynamic, num>>(),
        animate: true,
      ),
    );
  }
}

