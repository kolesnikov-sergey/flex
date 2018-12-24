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
      leading: CircleAvatar(
        child: Text(widget.position.name.substring(0, 2).toUpperCase(), style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red
      ),
      title: Text(widget.position.name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(widget.position.id),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Text(
            '${widget.position.qty} шт',
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.green)
          )
        ],
      )
    );
  }
}