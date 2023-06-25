import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'BarChart.dart';

class LineChartWidget extends StatelessWidget {
  final List<charts.Series<DataPoint, DateTime>> seriesList;
  final bool animate;

  LineChartWidget(this.seriesList, {required this.animate});

  factory LineChartWidget.withSampleData() {
    return LineChartWidget(
      _createSampleData(),
      animate: false,
    );
  }

  static List<charts.Series<DataPoint, DateTime>> _createSampleData() {
    final data = [
      DataPoint(DateTime(2023, 1, 1), 10),
      DataPoint(DateTime(2023, 2, 1), 20),
      DataPoint(DateTime(2023, 3, 1), 15),
      DataPoint(DateTime(2023, 7, 1), 18),
      DataPoint(DateTime(2023, 11, 4), 25),

      // Add more data points
    ];

    return [
      charts.Series<DataPoint, DateTime>(
        id: 'data',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (DataPoint point, _) => point.date,
        measureFn: (DataPoint point, _) => point.value,
        data: data,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('Line Chart'),

        actions: [
          IconButton(
            icon: const Icon(Icons.flip),
            tooltip: 'Open shopping cart',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>BarChartWidget.withSampleData()),);
            },
          ),
        ],

      ),

      body: Container(
        color: Colors.white,
        child: charts.TimeSeriesChart(
          seriesList,
          animate: true,
          dateTimeFactory: const charts.LocalDateTimeFactory(),
        ),
      ),
    );
  }
}

class DataPoint {
  final DateTime date;
  final int value;

  DataPoint(this.date, this.value);
}
