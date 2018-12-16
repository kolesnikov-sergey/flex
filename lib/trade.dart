import 'package:fl/number_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'buy_sell.dart';
import 'row_value.dart';

class Type extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoSegmentedControl(
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

class Trade extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сбербанк'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Type(),
            Padding(padding: EdgeInsets.only(top: 20)),
            NumberTextField(
              label: 'Количество',
              placeholder: 'Количество',
              initialValue: '1',
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            NumberTextField(
              label: 'Цена',
              placeholder: 'Цена',
              initialValue: '186.2',
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: RowValue(
                label: 'Стоимость',
                value: '1000 P',
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            BuySell()
          ],
        ) 
      ) 
    );
  }
}