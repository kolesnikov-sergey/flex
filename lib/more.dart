import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Портфель')
      ),
      body: Center(
        child: Text('Здесь будет что-то ещё'),
      )
    );
  }
}