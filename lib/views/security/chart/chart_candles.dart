import 'package:flutter/material.dart';
import 'package:flutter_candlesticks/flutter_candlesticks.dart';

import '../../../models/candle.dart';
import '../../../tools/currency_symbol.dart';

class ChartCandles extends StatelessWidget {
  final List<Candle> candles;

  ChartCandles(this.candles);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: OHLCVGraph(
        data: _createData(),
        enableGridLines: true,
        volumeProp: 0.2,
        labelPrefix: CurrencySymbol.currencies['RUB'],
      ),
    );
  }

  List _createData() {
    return candles
      .map((candle) => 
        {
          "open": candle.open,
          "high": candle.high,
          "low": candle.low,
          "close": candle.close,
          "volumeto": candle.volume
        },
      )
      .toList();
  }
}