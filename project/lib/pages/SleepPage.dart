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
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 97, 198, 171),
        elevation: 1,
        title: const Text ('Pagina relativa al sonno', 
        textAlign: TextAlign.center), 
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: ListView(
            children: [
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
                  IconButton( //freccia di sinistra
                      icon: const Icon(Icons.navigate_before),
                      onPressed: () {}),
                  Text('Data di oggi'),
                  IconButton(
                      icon: const Icon(Icons.navigate_next),
                      onPressed: () {})
                ],
              ),
              Center(
                child: Container(
                    //Initialize chart
                    child: SfCartesianChart(
                      // Chart title text
                      title: ChartTitle(text: 'Last night sleep'),
                      // Enables the legend
                      legend: Legend(isVisible: false),
                      // Initialize category axis
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                        // Initialize line series
                        StepLineSeries<ChartData, int>(
                          // Enables the tooltip for individual series
                          enableTooltip: true, 
                          dataSource: [
                              // Bind data source
                              ChartData(21, 0),
                              ChartData(23, -10),
                              ChartData(1, 15),
                              ChartData(3, -5),
                              ChartData(5, 0),
                              ChartData(7, 10),
                              ChartData(9, -5),
                          ],
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          // Render the data label
                          dataLabelSettings: DataLabelSettings(isVisible : true),
                          )
                    ])
                )
        )
      ])
    )
  );}
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double? y;
}