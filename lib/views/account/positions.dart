import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Position>>(
      future: Future.value(fakePositions),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => PositionItem(
              position: snapshot.data[index],
            ),
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(height: 1)
            ),
          );
        } else if (snapshot.hasError) {
          final snackBar = SnackBar(content: Text(snapshot.error.toString()));
          Scaffold.of(context).showSnackBar(snackBar);
          return Text(snapshot.error.toString());
        }

        return RefreshProgressIndicator();
      },
    );
  }
}