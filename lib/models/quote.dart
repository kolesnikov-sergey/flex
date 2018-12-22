import 'package:meta/meta.dart';

class Quote {
  final String id;
  final double last;
  final double bid;
  final double offer;
  final double spread;
  final double change;

  Quote({
    @required this.id,
    @required this.last,
    @required this.bid,
    @required this.offer,
    @required this.spread,
    @required this.change
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['SECID'] as String,
      last: json['LAST']?.toDouble(),
      bid: json['BID']?.toDouble(),
      offer: json['OFFER']?.toDouble(),
      spread: json['SPREAD']?.toDouble(),
      change: json['CHANGE']?.toDouble()
    );
  }
}