import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _Button extends StatelessWidget {
  const _Button({@required this.text, @required this.color, @required this.onPressed});

  final String text;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: CupertinoButton(
        padding: EdgeInsets.symmetric( horizontal: 10),
        color: color,
        child: Text(text),
        onPressed: onPressed,
      ),
    );
  }
}

class BuySell extends StatelessWidget {
  final VoidCallback onBuy;
  final VoidCallback onSell;

  const BuySell({@required this.onBuy, @required this.onSell});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _Button(
          text: 'Продать',
          color: Colors.red,
          onPressed: onSell,
        ),
        _Button(
          text: 'Купить',
          color: Colors.blue,
          onPressed: onBuy,
        )
      ],
    );
  }
}