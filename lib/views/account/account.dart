import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../connectors/connector.dart';
import 'positions.dart';

class Account extends StatelessWidget {
  final Connector connector;

  Account({@required this.connector});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Портфель')
      ),
      body: Positions(),
    );
  }
}