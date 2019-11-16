import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../connectors/connector.dart';
import '../../models/position.dart';
import '../ui/search_text_field.dart';
import 'position_tile.dart';

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
  final Connector connector = GetIt.I<Connector>();
  Stream<Position> stream;
  List<Position> positions = List();
  StreamSubscription subscription;
  String _search = '';

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

  void changeSearch(String value) {
    setState(() {
        _search = value;
    });
  }

  List<Position> filterPositions(List<Position> list) {
    return list
      .where((item) => item.name.toLowerCase().contains(_search?.toLowerCase())
        || item.id.toLowerCase().contains(_search?.toLowerCase())
      )
    .toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = filterPositions(positions);

    return Column(
      children: [
        Padding(
            padding: EdgeInsets.all(10),
            child: SearchTextField(onChanged: changeSearch),
        ),
        Flexible(
          child: ListView.separated(
            itemCount: items.length,
            itemBuilder: (context, index) => PositionTile(
              position: items[index],
            ),
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(height: 1, thickness: 1)
            ),
          ),
        ),
      ],
    );
  }
}