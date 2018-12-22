import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'chart.dart';
import '../../models/security.dart';
import '../../models/candle.dart';
import '../../connectors/iss_connector.dart';
import '../trade/trade.dart';

class SecurityInfo extends StatelessWidget {
  final Security security;
  final IssConnector connector;

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
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: SafeArea(
              child: CupertinoButton(
                child: Text('Заявка'),
                color: Theme.of(context).primaryColor,
                onPressed: () => Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context) => Trade(security: security)
                )),
              )
            )
          ),
        ],
      ),
    );
  }
}