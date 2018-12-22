import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Type extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Container(
      child: CupertinoSegmentedControl(
        borderColor: color,
        selectedColor: color,
        groupValue: 'Лимит',
        children: Map.fromIterable(
          ['Лимит', 'Маркет', 'Стоп'],
          key: (item) => item,
          value: (item) =>
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  item,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal
                  )
                ),
              )
            )
        ),
        onValueChanged: (item) => { },
      )
    );
  }
}
