import 'package:flutter/material.dart';

class OrderBookBox extends StatelessWidget {
  final String value;
  final Alignment alignment;
  final Color color;
  final double widthFactor;
  final bool border;
  final Widget child;

  OrderBookBox({
    @required this.value,
    @required this.alignment,
    this.color,
    this.child,
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
            child: child ?? Text(value ?? '-', style: TextStyle(fontWeight: FontWeight.bold))
          )

        ],
      )
    );
  }
}