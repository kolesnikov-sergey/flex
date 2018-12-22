import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../models/order_data.dart';

final orderTypes = {
  OrderType.limit: 'Лимит',
  OrderType.market: 'Маркет',
  OrderType.stop: 'Стоп'
};

class OrderTypeSelect extends StatelessWidget {
  final OrderType value;
  final ValueChanged<OrderType> onValueChanged;

  OrderTypeSelect({@required this.value, @required this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Container(
      child: CupertinoSegmentedControl(
        borderColor: color,
        selectedColor: color,
        groupValue: value,
        children: orderTypes.map(
          (key, value) => MapEntry(
            key, 
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal
                  )
                ),
              )
            )
          )
        ),
        onValueChanged: onValueChanged
      )
    );
  }
}
