import 'package:flutter/material.dart';

import '../../ui/number.dart';

class OrderBookBox extends StatelessWidget {
  final num value;
  final Alignment alignment;
  final int decimals;
  final Color color;
  final double widthFactor;
  final bool border;

  OrderBookBox({
    @required this.value,
    @required this.alignment,
    @required this.decimals,
    this.color,
    this.widthFactor = 0,
    this.border = false
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Align(
            alignment: alignment,
            child: FractionallySizedBox(
              widthFactor: widthFactor,
              alignment: alignment,
              child: Container(
                color: color,
                padding: EdgeInsets.all(15),
                child: Text('')
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            alignment: alignment,
            decoration: BoxDecoration(
              border: Border(
                left: border ? BorderSide(color: Colors.grey, width: 0.3) : BorderSide.none,
                right: border ? BorderSide(color: Colors.grey, width: 0.3) : BorderSide.none,
                bottom: BorderSide(color: Colors.grey, width: 0.3),
              ),
            ),
            child: value == null
              ? Text('-')
              : Number(
                decimals: decimals,
                value: value,
                style: Theme.of(context).textTheme.body2,
            ),
          )

        ],
      )
    );
  }
}