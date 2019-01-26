import 'package:flutter/material.dart';

import 'add_order.dart';
import '../ui/row_value.dart';

class Summary extends StatefulWidget {
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 10)),
                RowValue(
                  label: 'Открытие',
                  value: Text('10'),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Divider(),
                Padding(padding: EdgeInsets.only(top: 10)),
                RowValue(
                  label: 'Минимум',
                  value: Text('10'),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Divider(),
                Padding(padding: EdgeInsets.only(top: 10)),
                RowValue(
                  label: 'Максимум',
                  value: Text('10'),
                ),
              ],
            ),
          ),
        ),
        AddOrder(onPressed: (){})
      ],
    );
  }
}