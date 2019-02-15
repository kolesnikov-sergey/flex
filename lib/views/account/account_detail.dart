import 'package:flutter/material.dart';

class AccountDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('details'),
      ),
    );
  }
}