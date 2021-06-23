/// Example of an ordinal combo chart with two series rendered as bars, and a
/// third rendered as a line.
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class OrdinalComboBarLineChartWidget extends StatelessWidget {

  List<int> competition_Data;

  OrdinalComboBarLineChartWidget(this.competition_Data, {Key key}) : super(key: key);
  
  final List<charts.Series> seriesList;
  final bool animate;

  // OrdinalComboBarLineChartWidget(this.seriesList, {this.animate});

  factory OrdinalComboBarLineChartWidget.withSampleData() {
    

    return new OrdinalComboBarLineChartWidget(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    final List<int> competition_Data_=widget.competition_Data;
    return new charts.OrdinalComboChart(competition_Data_,
        animate: animate,
        // Configure the default renderer as a bar renderer.
        defaultRenderer: new charts.BarRendererConfig(
            groupingType: charts.BarGroupingType.grouped),
        // Custom renderer configuration for the line series. This will be used for
        // any series that does not define a rendererIdKey.
        customSeriesRenderers: [
          new charts.LineRendererConfig(
              // ID used to link series to this renderer.
              customRendererId: 'customLine')
        ]);
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2018', competition_Data_[0]),
      new OrdinalSales('2019', competition_Data_[1]),
      new OrdinalSales('2020', competition_Data_[2]),
      new OrdinalSales('2021', competition_Data_[3]),
    ];

    final tableSalesData = [
      new OrdinalSales('2018', competition_Data_[0]),
      new OrdinalSales('2019', competition_Data_[1]),
      new OrdinalSales('2020', competition_Data_[2]),
      new OrdinalSales('2021', competition_Data_[3]),
    ];

    final mobileSalesData = [
      new OrdinalSales('2018', competition_Data_[0]),
      new OrdinalSales('2019', competition_Data_[1]),
      new OrdinalSales('2020', competition_Data_[2]),
      new OrdinalSales('2021', competition_Data_[3]),
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