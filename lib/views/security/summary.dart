import 'package:flutter/material.dart';

import 'add_order.dart';
import '../../models/security.dart';
import '../ui/row_value.dart';
import '../ui/number_currency.dart';

class Summary extends StatefulWidget {
  final Security security;

  Summary({@required this.security});

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 10)),
                RowValue(
                  label: 'Открытие',
                  value: NumberCurrency(
                    value: widget.security.open,
                    currency: widget.security.currency,
                    decimals: widget.security.decimals,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Divider(),
                Padding(padding: EdgeInsets.only(top: 10)),
                RowValue(
                  label: 'Минимум',
                  value: NumberCurrency(
                    value: widget.security.low,
                    currency: widget.security.currency,
                    decimals: widget.security.decimals,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Divider(),
                Padding(padding: EdgeInsets.only(top: 10)),
                RowValue(
                  label: 'Максимум',
                  value: NumberCurrency(
                    value: widget.security.high,
                    currency: widget.security.currency,
                    decimals: widget.security.decimals,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Divider(),
                Padding(padding: EdgeInsets.only(top: 10)),
                RowValue(
                  label: 'Объем торгов',
                  value: NumberCurrency(
                    value: widget.security.valtoday.toDouble(),
                    currency: widget.security.currency,
                    decimals: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
        AddOrder(onPressed: (){})
      ],
    );
  }
}