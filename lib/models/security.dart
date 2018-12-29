import 'package:meta/meta.dart';

class Security {
  final String id;
  final String name;
  final double last;
  final double change;
  final int decimals;
  final double minStep;
  final int lotSize;
  final String currency;
  final double faceValue;

  Security({
    @required this.id,
    @required this.name,
    @required this.last,
    @required this.change,
    @required this.decimals,
    @required this.minStep,
    @required this.lotSize,
    @required this.currency,
    @required this.faceValue
  });

  factory Security.fromJson(Map<String, dynamic> json) {
    return Security(
      id: json['SECID'] as String ?? '',
      name: json['SHORTNAME'] as String ?? '',
      last: json['marketdata']['LAST']?.toDouble() ?? 0,
      change: json['marketdata']['CHANGE']?.toDouble() ?? 0,
      decimals: json['DECIMALS'],
      minStep: json['MINSTEP']?.toDouble() ?? 0,
      lotSize: json['LOTSIZE'] ?? 1,
      currency: json['CURRENCYID'],
      faceValue: json['FACEVALUE']?.toDouble() ?? 0
    );
  }
}

enum SecurityType {
  shares, bonds, currencies, futures
}