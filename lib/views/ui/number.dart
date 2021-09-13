import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Number extends StatelessWidget {
  final num value;
  final int decimals;
  final String? prefix;
  final TextStyle? style;

  Number({
    Key? key,
    required this.value,
    this.decimals = 2,
    this.prefix,
    this.style
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat(null, 'ru')
      ..minimumFractionDigits = decimals
      ..maximumFractionDigits = decimals;

    final formatted = format.format(value);

    return Text(
      formatted,
      style: style
    );
  }
}