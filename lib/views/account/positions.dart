import 'package:flutter/material.dart';

import '../../connectors/connector.dart';
import '../../models/position.dart';
import 'position_item.dart';

final fakePositions = [
  Position(id: 'SBER', name: 'СБЕРБАНК', qty: 10),
  Position(id: 'LKOH', name: 'ЛУКОЙЛ', qty: 20),
  Position(id: 'GAZP', name: 'ГАЗПРОМ', qty: 5)
];

class Positions extends StatefulWidget {
  final Connector connector;

  Positions({@required this.connector});

  @override
  _PositionsState createState() => _PositionsState();
}

class _PositionsState extends State<Positions> {
  Stream<Position> stream;
  List<Position> positions = List();

  @override
  void initState() {
    widget.connector.subscribePositions()
      .listen((pos) {
        setState(() {
          positions.add(pos);         
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    widget.connector.unsubscribePositions();
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