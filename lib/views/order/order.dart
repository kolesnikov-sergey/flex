import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'order_form.dart';
import '../../models/security.dart';

class Order extends StatelessWidget {
  final Security security;
  final double price;

  Order({@required this.security, this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(security.name)
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: OrderForm(security: security, price: price)
          )
        )  
      ) 
    );
  }
}