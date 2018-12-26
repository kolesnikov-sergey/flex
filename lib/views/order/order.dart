import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'order_form.dart';
import '../../connectors/connector.dart';
import '../../models/security.dart';

class Order extends StatelessWidget {
  final Security security;
  final Connector connector;

  Order({@required this.security, @required this.connector});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(security.name)
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: OrderForm(security: security, connector: connector) 
      ) 
    );
  }
}