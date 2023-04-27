import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text ('Esempio per costruzione Grafico', 
      textAlign: TextAlign.center), 
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      ),
      body: Center(
        child: Container(
            //Initialize chart
            child: SfCartesianChart(
              // Chart title text
              title: ChartTitle(text: 'Half yearly sales analysis'),
              // Enables the legend
              legend: Legend(isVisible: true),
              // Initialize category axis
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                // Initialize line series
                StepLineSeries<ChartData, int>(
                  // Enables the tooltip for individual series
                  enableTooltip: true, 
                  dataSource: [
                      // Bind data source
                      ChartData(2010, 32),
                      ChartData(2011, 40),
                      ChartData(2012, 34),
                      ChartData(2013, 52),
                      ChartData(2014, 42),
                      ChartData(2015, 38),
                      ChartData(2016, 41),
                  ],
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  // Render the data label
                  dataLabelSettings: DataLabelSettings(isVisible : true),
                  )
            ])
        )
      )   
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double? y;
}