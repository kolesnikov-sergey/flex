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
        _createData(),
        animate: true,
        primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false)
        )
      ),
    );
  }

  List<charts.Series<Candle, DateTime>> _createData() {
    return [
      new charts.Series<Candle, DateTime>(
        id: 'Trade',
        colorFn: (_, __) => charts.MaterialPalette.black,
        domainFn: (Candle candle, _) => candle.begin,
        measureFn: (Candle candle, _) => candle.open,
        data: candles,
      )
    ];
  }
}