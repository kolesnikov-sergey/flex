import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'buy_sell.dart';
import 'trade.dart';

class SecurityInfo extends StatelessWidget {
  final String name;

  const SecurityInfo({@required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(name)
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: Center(
                child: Text('Тут будет график'),
              ),
            )
            ,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: BuySell(
              onBuy: () => Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) => Trade(name: name)
              )),
              onSell: () => Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) => Trade(name: name)
              ))
            ),
          )
        ],
      ),
    );
  }
}