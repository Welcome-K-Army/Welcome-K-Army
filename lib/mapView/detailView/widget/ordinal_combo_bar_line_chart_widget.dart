/// Example of an ordinal combo chart with two series rendered as bars, and a
/// third rendered as a line.
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'competition_chart_widget.dart';

class OrdinalComboBarLineChartWidget extends StatefulWidget {
  //생성자
  final List<charts.Series> seriesList;
  final bool animate;
  // final List<int> competition_data;

  OrdinalComboBarLineChartWidget(this.seriesList,{this.animate});

  factory OrdinalComboBarLineChartWidget.withSampleData(competiton) {
    return new OrdinalComboBarLineChartWidget(
      _createSampleData(competiton),
      animate: false,
    );
  }


  static List<charts.Series<OrdinalSales, String>> _createSampleData(competiton) {


    final manData = [
      new OrdinalSales('2018', 10),
      new OrdinalSales('2019', 20),
      new OrdinalSales('2020', 60),
      new OrdinalSales('2021', 70),
    ];

    final womanData = [
      new OrdinalSales('2018', 5),
      new OrdinalSales('2019', 1),
      new OrdinalSales('2020', 5),
      new OrdinalSales('2021', 70),
    ];

    return [
      new charts.Series<OrdinalSales, String>(id: 'man', colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault, domainFn: (OrdinalSales sales, _) => sales.year, measureFn: (OrdinalSales sales, _) => sales.sales, data: manData),
      new charts.Series<OrdinalSales, String>(id: 'girl ', colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault, domainFn: (OrdinalSales sales, _) => sales.year, measureFn: (OrdinalSales sales, _) => sales.sales, data: womanData)
        // Configure our custom line renderer for this series.
        // ..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }

  @override
  _OrdinalComboBarLineChartWidgetState createState() => _OrdinalComboBarLineChartWidgetState(seriesList, animate);
}

class _OrdinalComboBarLineChartWidgetState extends State<OrdinalComboBarLineChartWidget> {

  final List<charts.Series> seriesList;
  final bool animate;

  _OrdinalComboBarLineChartWidgetState(this.seriesList, this.animate);

  @override
  Widget build(BuildContext context) {
    return new charts.OrdinalComboChart(seriesList,
        animate: animate,
        // Configure the default renderer as a bar renderer.
        defaultRenderer: new charts.BarRendererConfig(groupingType: charts.BarGroupingType.grouped),
        // Custom renderer configuration for the line series. This will be used for
        // any series that does not define a rendererIdKey.
        customSeriesRenderers: [
          new charts.LineRendererConfig(
              // ID used to link series to this renderer.
              customRendererId: 'customLine')
        ]);
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
