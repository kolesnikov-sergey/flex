import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final currencies = {
  'RUB': '\u20BD',
  'RUR': '\u20BD',
  'USD': '\$',
  'EUR': '€',
};


class NumberCurrency extends StatelessWidget {
  final double value;
  final String currency;
  final int decimals;
  final TextStyle style;
  final TextAlign textAlign;

  NumberCurrency({
    Key key,
    @required this.value,
    @required this.currency,
    this.decimals = 2,
    this.style,
    this.textAlign
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      NumberFormat.currency(
        locale: 'ru',
        symbol: _getCurrencySymbol(currency),
        decimalDigits: decimals
      ).format(value),
      style: style,
      textAlign: textAlign,
    );
  }

  String _getCurrencySymbol(String value) {
    return currencies[value.toUpperCase()] ?? value;
  }
}