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
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: <Widget>[
          NumberCurrency(
            currency: 'шт',
            value: widget.position.qty.toDouble(),
            decimals: 0,
            textAlign: TextAlign.start,
          ),
          NumberCurrency(
            currency: 'RUB',
            value: 123,
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      )
    );
  }
}