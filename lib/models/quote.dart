import 'package:meta/meta.dart';

class Quote {
  final String id;
  double last;
  double bid;
  double offer;
  double spread;
  double change;

  Quote({
    @required this.id,
    @required this.last,
    @required this.bid,
    @required this.offer,
    @required this.spread,
    @required this.change,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['SECID'] as String ?? '',
      last: json['LAST']?.toDouble() ?? 0,
      bid: json['BID']?.toDouble() ?? 0,
      offer: json['OFFER']?.toDouble() ?? 0,
      spread: json['SPREAD']?.toDouble() ?? 0,
      change: json['CHANGE']?.toDouble() ?? 0,
    );
  }

  void merge(Quote quote) {
    last = quote.last;
    bid = quote.bid;
    offer = quote.offer;
    spread = quote.spread;
    change = quote.change;
  }
}