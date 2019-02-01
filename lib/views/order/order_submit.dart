import 'package:flutter/material.dart';

class _Button extends StatelessWidget {
  const _Button({@required this.text, this.color, @required this.onPressed});

  final String text;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: RaisedButton(
        color: color,
        child: Text(text, style: TextStyle(color: Colors.white)), // TODO fix
        onPressed: onPressed,
      ),
    );
  }
}

class OrderSubmit extends StatelessWidget {
  final VoidCallback onBuy;
  final VoidCallback onSell;

  OrderSubmit({@required this.onBuy, @required this.onSell});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _Button(
          text: 'ПРОДАТЬ',
          color: Colors.red,
          onPressed: onSell,
        ),
        _Button(
          text: 'КУПИТЬ',
          onPressed: onBuy,
        )
      ],
    );
  }
}