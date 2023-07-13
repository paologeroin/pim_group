import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../models/entities/entities.dart';
import '../services/sleepData.dart';

class SleepChart extends StatelessWidget {
  final List<Data> sleepPhasesData;

  SleepChart({required this.sleepPhasesData});
  
  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      [createSeries()],
      animate: true,
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
      ),
      domainAxis: charts.DateTimeAxisSpec(
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          hour: charts.TimeFormatterSpec(
            format: 'HH:mm',
            transitionFormat: 'HH:mm',
          ),
        ),
      ),
    );
  }

  charts.Series<Data, DateTime> createSeries() {
  return charts.Series<Data, DateTime>(
    id: 'Sleep',
    colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
    domainFn: (Data data, _) => DateTime.parse(data.dateTime),
    measureFn: (Data data, _) => data.seconds,
    data: sleepPhasesData,
    );
  }//createSeries
}//SleepChart


