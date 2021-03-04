import 'package:flutter/material.dart';
import 'package:flutter_candlesticks_chart/flutter_candlesticks_chart.dart';

import '../../../models/candle.dart';
import '../../../tools/currency_symbol.dart';

class ChartCandles extends StatelessWidget {
  final List<Candle> candles;

  ChartCandles(this.candles);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: CandleStickChart(
        data: _createData(),
        //enableGridLines: true,
        volumeProp: 0.2,
        //labelPrefix: CurrencySymbol.currencies['RUB'],
      ),
    );
  }

  List<CandleStickChartData> _createData() {
    return candles
      .map((candle) => CandleStickChartData(
        open: candle.open,
        close: candle.close,
        high: candle.high,
        low: candle.low,
        volume: candle.volume,
        dateTime: candle.begin,
      ))
      .toList();
  }
}