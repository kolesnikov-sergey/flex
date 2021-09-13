import 'package:flutter/material.dart';
import 'package:interactive_chart/interactive_chart.dart';

import '../../../models/candle.dart';
import '../../../tools/currency_symbol.dart';

class ChartCandles extends StatelessWidget {
  final List<Candle> candles;

  ChartCandles(this.candles);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InteractiveChart(
        candles: _createData(),
        //enableGridLines: true,
        // volumeProp: 0.2,
        //labelPrefix: CurrencySymbol.currencies['RUB'],
      ),
    );
  }

  List<CandleData> _createData() {
    return candles
      .map((candle) => CandleData(
        open: candle.open,
        close: candle.close,
        high: candle.high,
        low: candle.low,
        volume: candle.volume,
        timestamp: candle.begin.millisecondsSinceEpoch,
      ))
      .toList();
  }
}