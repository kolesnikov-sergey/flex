import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../models/candle.dart';

class Chart extends StatelessWidget {
  final List<Candle> candles;

  Chart(this.candles);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: charts.TimeSeriesChart(
        _createData(context),
        animate: false,
        behaviors: [
          // Add the sliding viewport behavior to have the viewport center on the
          // domain that is currently selected.
          charts.SlidingViewport(),
          // A pan and zoom behavior helps demonstrate the sliding viewport
          // behavior by allowing the data visible in the viewport to be adjusted
          // dynamically.
          charts.PanAndZoomBehavior(),
        ],
        domainAxis: charts.DateTimeAxisSpec(
          viewport: charts.DateTimeExtents(start: candles[max(candles.length - 10, 0)].begin, end: candles[candles.length - 1].begin)
        ),
        primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false)
        )
      ),
    );
  }

  List<charts.Series<Candle, DateTime>> _createData(BuildContext context) {
    return [
      new charts.Series<Candle, DateTime>(
        id: 'Trade',
        colorFn: (_, __) => Theme.of(context).brightness == Brightness.dark
          ? charts.MaterialPalette.blue.shadeDefault
          : charts.MaterialPalette.black,
        domainFn: (Candle candle, _) => candle.begin,
        measureFn: (Candle candle, _) => candle.open,
        data: candles,
      )
    ];
  }
}