import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../models/candle.dart';

class Chart extends StatelessWidget {
  final List<Candle> candles;

  Chart(this.candles);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: charts.TimeSeriesChart(
        _createData(context),
        animate: true,
        defaultInteractions: false,
        animationDuration: Duration(milliseconds: 10),
        behaviors: [
          charts.SlidingViewport(),
          charts.PanAndZoomBehavior(),
        ],
        domainAxis: charts.DateTimeAxisSpec(
          tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
            year: charts.TimeFormatterSpec(
              format: 'yyyy',
              transitionFormat: 'yyyy'
            ),
            month: charts.TimeFormatterSpec(
              format: 'MMMM', transitionFormat: 'yyyy MMMM'
            )
          ),
          viewport: candles.length > 0
            ? charts.DateTimeExtents(
                start: candles[max(candles.length - 20, 0)].begin,
                end: candles[candles.length - 1].begin
              )
            : null,
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(color: charts.MaterialPalette.white),
            lineStyle: charts.LineStyleSpec(
              thickness: 0
            )
          )
        ),
        
        primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(color: charts.MaterialPalette.white),
            lineStyle: charts.LineStyleSpec(
              thickness: 0
            )
          )
        )
      ),
    );
  }

  List<charts.Series<Candle, DateTime>> _createData(BuildContext context) {
    return [
      new charts.Series<Candle, DateTime>(
        id: 'Trade',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Candle candle, _) => candle.begin,
        measureFn: (Candle candle, _) => candle.open,
        data: candles,
      )
    ];
  }
}