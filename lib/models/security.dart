import 'package:meta/meta.dart';

class Security {
  final String id;
  final String name;
  final double last;
  final double change;
  final int decimals;
  final double minStep;
  final int lotSize;

  Security({
    @required this.id,
    @required this.name,
    @required this.last,
    @required this.change,
    @required this.decimals,
    @required this.minStep,
    @required this.lotSize
  });

  factory Security.fromJson(Map<String, dynamic> json) {
    return Security(
      id: json['SECID'] as String,
      name: json['SHORTNAME'] as String,
      last: json['marketdata']['LAST']?.toDouble(),
      change: json['marketdata']['CHANGE']?.toDouble(),
      decimals: json['DECIMALS'],
      minStep: json['MINSTEP']?.toDouble(),
      lotSize: json['LOTSIZE']
    );
  }
}

enum SecurityType {
  shares, bonds, currencies, futures
}