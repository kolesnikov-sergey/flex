import 'dart:async';

import 'package:flutter/material.dart';

import '../../connectors/connector.dart';
import '../../connectors/connector_factory.dart';
import '../../models/position.dart';
import 'position_item.dart';

final fakePositions = [
  Position(id: 'SBER', name: 'СБЕРБАНК', qty: 10),
  Position(id: 'LKOH', name: 'ЛУКОЙЛ', qty: 20),
  Position(id: 'GAZP', name: 'ГАЗПРОМ', qty: 5)
];

class Positions extends StatefulWidget {
  @override
  _PositionsState createState() => _PositionsState();
}

class _PositionsState extends State<Positions> {
  final Connector connector = ConnectorFactory.getConnector();
  Stream<Position> stream;
  List<Position> positions = List();
  StreamSubscription subscription;

  @override
  void initState() {
    subscription = connector.subscribePositions()
      .listen((pos) {
        setState(() {
          positions.add(pos);         
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    connector.unsubscribePositions();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: positions.length,
      itemBuilder: (context, index) => PositionItem(
        position: positions[index],
      ),
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(height: 1)
      ),
    );
  }
}