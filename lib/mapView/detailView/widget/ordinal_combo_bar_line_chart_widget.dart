/// Example of an ordinal combo chart with two series rendered as bars, and a
/// third rendered as a line.
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class OrdinalComboBarLineChartWidget extends StatelessWidget {


  // OrdinalComboBarLineChartWidget({Key? key, required this.competition_data_},{this.animate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series> seriesList = _createSampleData();
    return MaterialApp(
        home: Container(
            height: 205.0,
            width: 350.0,
            child: charts.OrdinalComboChart(seriesList,
                animate: false,
                defaultRenderer: charts.LineRendererConfig(
                    areaOpacity: 0.8, includeArea: true),
                customSeriesRenderers: [
                  new charts.LineRendererConfig(customRendererId: 'LineOne'),
                ])));
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2018', 100),
      new OrdinalSales('2019', 50),
      new OrdinalSales('2020', 200),
      new OrdinalSales('2021', 10),
    ];

    final tableSalesData = [
      new OrdinalSales('2018', 100),
      new OrdinalSales('2019', 50),
      new OrdinalSales('2020', 200),
      new OrdinalSales('2021', 10),
    ];

    final mobileSalesData = [
      new OrdinalSales('2018', 100),
      new OrdinalSales('2019', 50),
      new OrdinalSales('2020', 200),
      new OrdinalSales('2021', 10),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
          id: 'Desktop',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: desktopSalesData),
      new charts.Series<OrdinalSales, String>(
          id: 'Tablet',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: tableSalesData),
      new charts.Series<OrdinalSales, String>(
          id: 'Mobile ',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: mobileSalesData)
        // Configure our custom line renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}