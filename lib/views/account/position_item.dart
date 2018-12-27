import 'package:flutter/material.dart';

import '../../models/position.dart';

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
          Text(
            '${widget.position.qty} шт',
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold)
          )
        ],
      )
    );
  }
}