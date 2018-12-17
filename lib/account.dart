import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Портфель'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text('Здесь будет информация о портфеле'),
      ),
    );
  }
}