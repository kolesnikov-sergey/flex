import 'package:flutter/material.dart';

import 'add_order_button.dart';
import '../../models/security.dart';
import '../ui/row_value.dart';
import '../ui/number_currency.dart';

class Summary extends StatelessWidget {
  final Security security;
  final ValueChanged<double> onAddOrder;

  Summary({@required this.security, @required this.onAddOrder});

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
                    value: security.open,
                    currency: security.currency,
                    decimals: security.decimals,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Divider(),
                Padding(padding: EdgeInsets.only(top: 10)),
                RowValue(
                  label: 'Минимум',
                  value: NumberCurrency(
                    value: security.low,
                    currency: security.currency,
                    decimals: security.decimals,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Divider(),
                Padding(padding: EdgeInsets.only(top: 10)),
                RowValue(
                  label: 'Максимум',
                  value: NumberCurrency(
                    value: security.high,
                    currency: security.currency,
                    decimals: security.decimals,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Divider(),
                Padding(padding: EdgeInsets.only(top: 10)),
                RowValue(
                  label: 'Покупка',
                  value: NumberCurrency(
                    value: security.bid,
                    currency: security.currency,
                    decimals: security.decimals,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Divider(),
                Padding(padding: EdgeInsets.only(top: 10)),
                RowValue(
                  label: 'Продажа',
                  value: NumberCurrency(
                    value: security.offer,
                    currency: security.currency,
                    decimals: security.decimals,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Divider(),
                Padding(padding: EdgeInsets.only(top: 10)),
                RowValue(
                  label: 'Объем торгов',
                  value: NumberCurrency(
                    value: security.valtoday,
                    currency: security.currency,
                    decimals: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
        AddOrderButton(onPressed: () => onAddOrder(null))
      ],
    );
  }
}
