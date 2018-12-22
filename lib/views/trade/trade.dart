import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'number_text_field.dart';
import 'buy_sell.dart';
import 'row_value.dart';
import 'type.dart';

import '../../models/security.dart';

class Trade extends StatelessWidget {
  final Security security;

  const Trade({@required this.security});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(security.name)
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
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
            BuySell(
              onBuy: () => Navigator.pop(context),
              onSell: () => Navigator.pop(context),
            )
          ],
        ) 
      ) 
    );
  }
}