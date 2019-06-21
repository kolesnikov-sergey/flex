import 'dart:async';

import 'package:flutter/material.dart';

import 'chart.dart';
import '../add_order_button.dart';
import '../../../models/security.dart';
import '../../../models/candle.dart';
import '../../../connectors/connector.dart';
import '../../../connectors/connector_factory.dart';
import '../../ui/flex_future_builder.dart';

class ChartView extends StatefulWidget {
  final Security security;
  final SecurityType securityType;
  final ValueChanged<double> onAddOrder;

  ChartView({
    @required this.security,
    @required this.securityType,
    @required this.onAddOrder
  });

  @override
  _ChartInfoState createState() => _ChartInfoState();
}

class _ChartInfoState extends State<ChartView> {
  final Connector connector = ConnectorFactory.getConnector();
  Future<List<Candle>> candles;
  
  @override
  void initState() {
    _load();
    super.initState();
  }

  @override
  void didUpdateWidget(ChartView oldWidget) {
    if(oldWidget.security != widget.security) {
      _load();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _load() {
    setState(() {
      candles = connector.getCandles(widget.security.id, widget.securityType);
    });
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
              AddOrderButton(onPressed: () => widget.onAddOrder(null))
            ],
          );
      },
      onRetry: _load,
    );
  }
}