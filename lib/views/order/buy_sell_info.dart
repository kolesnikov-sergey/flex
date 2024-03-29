import 'package:flutter/material.dart';

import '../../models/quote.dart';
import '../../models/security.dart';
import '../ui/number_currency.dart';

class BuySellInfo extends StatelessWidget {
  final Security security;
  final Quote? quote;

  BuySellInfo({required this.security, this.quote});

  @override
  Widget build(BuildContext context) {
    final bid = quote == null ? security.bid : quote!.bid;
    final offer = quote == null ? security.offer : quote!.offer;

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
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                NumberCurrency(
                  value: bid,
                  currency: security.currency,
                  style: Theme.of(context).textTheme.subtitle2?.apply(color: Colors.pink),
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
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                NumberCurrency(
                  value: offer,
                  currency: security.currency,
                  style: Theme.of(context).textTheme.subtitle2?.apply(color: Colors.green),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}