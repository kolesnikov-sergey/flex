import 'dart:async';

import 'package:flex/state/positions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: BlocBuilder<PositionsCubit, List<Position>>(
            builder: (context, positions) => ListView.separated(
              itemCount: positions.length,
              itemBuilder: (context, index) => PositionTile(
                position: positions[index],
              ),
              separatorBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(height: 1, thickness: 1)
              ),
            )
          )  ,
        ),
      ],
    );
  }
}