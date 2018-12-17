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
        title: Text(name),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 600,
            color: Colors.grey[100],
            child: Center(
              child: Text('Тут будет график'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
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