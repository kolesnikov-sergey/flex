class Security {
  final String id;
  final String name;
  final double open;
  final double last;
  final double high;
  final double low;
  final double bid;
  final double offer;
  final int valtoday;
  final double change;
  final int decimals;
  final double minStep;
  final int lotSize;
  final String currency;
  final double faceValue;

  Security({
    required this.id,
    required this.name,
    required this.open,
    required this.last,
    required this.high,
    required this.low,
    required this.bid,
    required this.offer,
    required this.valtoday,
    required this.change,
    required this.decimals,
    required this.minStep,
    required this.lotSize,
    required this.currency,
    required this.faceValue
  });

  factory Security.fromJson(Map<String, dynamic> json) {
    return Security(
      id: json['SECID'] ?? '',
      name: json['SHORTNAME'] ?? '',
      open: json['marketdata']['OPEN']?.toDouble() ?? 0,
      last: json['marketdata']['LAST']?.toDouble() ?? 0,
      high: json['marketdata']['HIGH']?.toDouble() ?? 0,
      low: json['marketdata']['LOW']?.toDouble() ?? 0,
      bid: json['marketdata']['BID']?.toDouble() ?? 0,
      offer: json['marketdata']['OFFER']?.toDouble() ?? 0,
      valtoday: json['marketdata']['VALTODAY']?.toInt() ?? 0,
      change: json['marketdata']['CHANGE']?.toDouble() ?? 0,
      decimals: json['DECIMALS'],
      minStep: json['MINSTEP']?.toDouble() ?? 0,
      lotSize: json['LOTSIZE'] ?? 1,
      currency: json['CURRENCYID'] ?? '',
      faceValue: json['FACEVALUE']?.toDouble() ?? 0
    );
  }
}

enum SecurityType {
  shares, bonds, currencies, futures
}