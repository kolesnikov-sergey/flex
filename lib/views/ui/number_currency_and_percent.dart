import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../tools/currency_symbol.dart';

class NumberCurrencyAndPercent extends StatelessWidget {
  final num value;
  final num valuePercent;
  final String currency;
  final int decimals;
  final String prefix;
  final TextStyle style;
  final TextAlign textAlign;

  NumberCurrencyAndPercent({
    Key key,
    @required this.value,
    @required this.valuePercent,
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
        decimalDigits: decimals,
    ).format(value);

    final formatPercent = NumberFormat.percentPattern('ru')
      ..minimumFractionDigits = 2
      ..maximumFractionDigits = 2;

    final formattedPercent = formatPercent.format(valuePercent);
  
    return Text(
      '${prefix == null ? '' : prefix}$formatted (${prefix == null ? '' : prefix}$formattedPercent)',
      style: style,
      textAlign: textAlign,
    );
  }
}