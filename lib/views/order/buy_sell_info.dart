import 'package:flutter/material.dart';

import '../../models/security.dart';
import '../ui/number_currency.dart';

class BuySellInfo extends StatelessWidget {
  final Security security;

  BuySellInfo({@required this.security});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 72, right: 72, bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Покупка:',
                style: Theme.of(context).textTheme.subhead,
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              NumberCurrency(
                value: security.last, // TODO fix
                currency: security.currency,
                style: Theme.of(context).textTheme.subtitle.apply(color: Colors.pink),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Продажа:',
                style: Theme.of(context).textTheme.subhead,
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              NumberCurrency(
                value: security.last,
                currency: security.currency, // TODO fix
                style: Theme.of(context).textTheme.subtitle.apply(color: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}