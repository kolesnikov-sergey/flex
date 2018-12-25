import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../tools/currency_symbol.dart';

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
        symbol: CurrencySymbol.getCurrencySymbol(currency),
        decimalDigits: decimals
      ).format(value),
      style: style,
      textAlign: textAlign,
    );
  }
}