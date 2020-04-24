import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'chart_candles.dart';
import '../add_order_button.dart';
import '../../../models/security.dart';
import '../../../models/candle.dart';
import '../../../connectors/connector.dart';
import '../../ui/flex_future_builder.dart';

class ChartView extends StatefulWidget {
  final Security security;
  final SecurityType securityType;
  final ValueChanged<double> onAddOrder;

  ChartView({
    @required this.security,
    @required this.securityType,
    this.onAddOrder
  });

  @override
  _ChartInfoState createState() => _ChartInfoState();
}

class _ChartInfoState extends State<ChartView> {
  final Connector connector = GetIt.I<Connector>();
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
                child: ChartCandles(snapshot.data)    
              ),
              if (widget.onAddOrder != null) AddOrderButton(onPressed: () => widget.onAddOrder(null))
            ],
          );
      },
      onRetry: _load,
    );
  }
}