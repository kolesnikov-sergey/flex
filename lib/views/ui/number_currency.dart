import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../tools/currency_symbol.dart';

class NumberCurrency extends StatelessWidget {
  final double value;
  final String currency;
  final int decimals;
  final String prefix;
  final TextStyle style;
  final TextAlign textAlign;

  NumberCurrency({
    Key key,
    @required this.value,
    @required this.currency,
    this.decimals = 2,
    this.prefix,
    this.style,
    this.textAlign
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatted = NumberFormat.currency(
        locale: 'ru',
        symbol: currency == null ? null : CurrencySymbol.getCurrencySymbol(currency),
        decimalDigits: decimals
    ).format(value);
    return Text(
      '${prefix == null ? '' : prefix}$formatted',
      style: style,
      textAlign: textAlign,
    );
  }
}