import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'chart.dart';
import '../../models/security.dart';
import '../../models/candle.dart';
import '../../connectors/connector.dart';
import '../order/order.dart';

class SecurityInfo extends StatelessWidget {
  final Security security;
  final Connector connector;

  const SecurityInfo({@required this.security, @required this.connector});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(security.name)
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder<List<Candle>>(
              future: connector.getCandles(security.id),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Chart(snapshot.data);
                }
                if(snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                return Center(child: CircularProgressIndicator());
              },
            )
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
              top: 20
            ),
            child: SafeArea(
              child: MaterialButton(
                minWidth: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text('Заявка', style: TextStyle(fontSize: 16))
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryTextTheme.button.color,
                onPressed: () => Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context) => Order(security: security, connector: connector)
                )),
              )
            )
          ),
        ],
      ),
    );
  }
}