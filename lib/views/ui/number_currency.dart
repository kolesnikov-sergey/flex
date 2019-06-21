import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../tools/currency_symbol.dart';

class NumberCurrency extends StatelessWidget {
  final num value;
  final String currency;
  final int decimals;
  final String prefix;
  final TextStyle style;

  NumberCurrency({
    Key key,
    @required this.value,
    @required this.currency,
    this.decimals = 2,
    this.prefix,
    this.style
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatted = NumberFormat.currency(
        locale: 'ru',
        symbol: currency == null ? null : CurrencySymbol.getCurrencySymbol(currency),
        decimalDigits: decimals,
    ).format(value);
    return Text(
      '${prefix == null ? '' : prefix}$formatted',
      style: style
    );
  }
}