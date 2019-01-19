import 'package:flutter/material.dart';

import 'chart.dart';
import 'add_order.dart';
import '../../models/security.dart';
import '../../models/candle.dart';
import '../../connectors/connector.dart';
import '../order/order.dart';
import '../ui/flex_future_builder.dart';

class ChartInfo extends StatefulWidget {
  final Security security;
  final SecurityType securityType;
  final Connector connector;

  ChartInfo({
    @required this.security,
    @required this.securityType,
    @required this.connector
  });

  @override
  _ChartInfoState createState() => _ChartInfoState();
}

class _ChartInfoState extends State<ChartInfo> {
  Future<List<Candle>> candles;
  
  @override
  void initState() {
    _load();
    super.initState();
  }

  @override
  void didUpdateWidget(ChartInfo oldWidget) {
    if(oldWidget.security != widget.security) {
      _load();
    }
    super.didUpdateWidget(oldWidget);
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
    return FlexFutureBuilder<List<Candle>>(
      future: candles,
      builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Chart(snapshot.data)    
              ),
              AddOrder(onPressed: _navigateToOrder)
            ],
          );
      },
      onRetry: _load,
    );
  }
}