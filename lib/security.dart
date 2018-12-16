import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'buy_sell.dart';

class Security extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Лукойл'),
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
            child: BuySell(),
          )
        ],
      ),
    );
  }
}