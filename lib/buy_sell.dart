import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _Button extends StatelessWidget {
  const _Button({@required this.text, @required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: CupertinoButton(
        padding: EdgeInsets.symmetric( horizontal: 10),
        color: color,
        child: Text(text),
        onPressed: () => {},
      ),
    );
  }
}

class BuySell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _Button(
          text: 'Продать',
          color: Colors.red,
        ),
        _Button(
          text: 'Купить',
          color: Colors.blue,
        )
      ],
    );
  }
}