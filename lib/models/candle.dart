import 'package:meta/meta.dart';

class Candle {
  final double open;
  final double close;
  final double high;
  final double low;
  final double value;
  final double volume;
  final DateTime begin;
  final DateTime end;

  Candle({
    @required this.open,
    @required this.close,
    @required this.high,
    @required this.low,
    @required this.value,
    @required this.volume,
    @required this.begin,
    @required this.end
  });

  factory Candle.fromJson(Map<String, dynamic> json) {
    return Candle(
      open: json['open']?.toDouble(),
      close: json['close']?.toDouble(),
      high: json['high']?.toDouble(),
      low: json['low']?.toDouble(),
      value: json['value']?.toDouble(),
      volume: json['volume']?.toDouble(),
      begin: DateTime.parse(json['begin']),
      end: DateTime.parse(json['end'])
    );
  }
}