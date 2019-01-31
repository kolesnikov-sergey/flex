import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'positions.dart';

class Account extends StatelessWidget {
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