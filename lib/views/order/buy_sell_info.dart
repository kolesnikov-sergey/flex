import 'package:flutter/material.dart';

import '../../models/security.dart';
import '../ui/number_currency.dart';

class BuySellInfo extends StatelessWidget {
  final Security security;

  BuySellInfo({@required this.security});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 350),
      child: Padding(
        padding: const EdgeInsets.only(left: 70, right: 70, bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Покупка:',
                  style: Theme.of(context).textTheme.subhead.apply(color: Colors.white),
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                NumberCurrency(
                  value: security.bid,
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
                  style: Theme.of(context).textTheme.subhead.apply(color: Colors.white),
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                NumberCurrency(
                  value: security.offer,
                  currency: security.currency,
                  style: Theme.of(context).textTheme.subtitle.apply(color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}