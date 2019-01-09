import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'chart.dart';
import '../../models/security.dart';
import '../../models/candle.dart';
import '../../connectors/connector.dart';
import '../order/order.dart';
import '../ui/flex_future_builder.dart';

class SecurityInfo extends StatefulWidget {
  final Security security;
  final SecurityType securityType;
  final Connector connector;

  const SecurityInfo({
    @required this.security,
    @required this.securityType,
    @required this.connector
  });

  @override
  _SecurityInfoState createState() => _SecurityInfoState();
}

class _SecurityInfoState extends State<SecurityInfo> {
  Future<List<Candle>> candles;
  
  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() {
    setState(() {
      candles = widget.connector.getCandles(widget.security.id, widget.securityType);
    });
  }

  void _navigateToOrder() {
    Navigator.push(context, new MaterialPageRoute(
      builder: (BuildContext context) => Order(security: widget.security, connector: widget.connector)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(widget.security.name)
      ),
      body: FlexFutureBuilder<List<Candle>>(
        future: candles,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Chart(snapshot.data)    
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
                      padding: EdgeInsets.all(12),
                      child: Text('ЗАЯВКА', style: TextStyle(fontSize: 16))
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                    onPressed: _navigateToOrder,
                  )
                )
              )
            ],
          );
        },
        onRetry: _load,
      )
    );
  }
}
