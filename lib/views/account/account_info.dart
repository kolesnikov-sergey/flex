import 'package:flutter/material.dart';
import '../ui/number_currency.dart';

class AccountInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 17, bottom: 20),
      child: Row(
        mainAxisAlignment: Theme.of(context).platform == TargetPlatform.iOS
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          NumberCurrency(
            value: 100000.34,
            currency: 'RUB',
            style: Theme.of(context).textTheme.title,
          ),
          Padding(padding: EdgeInsets.only(left: 10)),
          NumberCurrency(
            value: 100.78,
            currency: 'RUB',
            prefix: '+',
            style: Theme.of(context).textTheme.subtitle.apply(color: Colors.green),
          ),
          Padding(padding: EdgeInsets.only(left: 10)),
          IconButton(
            padding: EdgeInsets.all(0),
            alignment: Alignment.bottomCenter,
            icon: Icon(Icons.info_outline),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}