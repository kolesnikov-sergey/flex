import 'package:flutter/material.dart';

import '../../models/position.dart';
import '../ui/number_currency.dart';

class PositionItem extends StatefulWidget {
  final Position position;

  PositionItem({this.position});

  @override
  _PositionItemState createState() => _PositionItemState();
}

class _PositionItemState extends State<PositionItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.position.name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(widget.position.id),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          NumberCurrency(
            currency: 'шт',
            value: widget.position.qty,
            decimals: 0,
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
          Padding(
            padding: EdgeInsets.only(top: 2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              NumberCurrency(
                currency: '%',
                prefix: '+',
                value: 12.23,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.green
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              NumberCurrency(
                currency: 'RUB',
                value: 123,
                textAlign: TextAlign.start,
              )
            ],
          ),
          
        ],
      )
    );
  }
}