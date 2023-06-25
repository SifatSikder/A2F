import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class BarChartWidget extends StatelessWidget {
  final List<charts.Series<DataPoint, String>> seriesList;
  final bool animate;

  BarChartWidget(this.seriesList, {required this.animate});

  factory BarChartWidget.withSampleData() {
    return BarChartWidget(
      _createSampleData(),
      animate: false,
    );
  }

  static List<charts.Series<DataPoint, String>> _createSampleData() {
    final data = [
      DataPoint('Category 1', 10),
      DataPoint('Category 2', 20),
      DataPoint('Category 3', 15),
      // Add more data points
    ];

    return [
      charts.Series<DataPoint, String>(
        id: 'data',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (DataPoint point, _) => point.category,
        measureFn: (DataPoint point, _) => point.value,
        data: data,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        title: Text('Bar Chart'),



      ),


      body:Container(
        color: Colors.white,
        child: charts.BarChart(
          seriesList,
          animate: animate,
        ),
      ),
    );
  }
}

class DataPoint {
  final String category;
  final int value;

  DataPoint(this.category, this.value);
}
