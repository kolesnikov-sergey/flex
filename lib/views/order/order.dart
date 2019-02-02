import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'order_form.dart';
import '../../models/security.dart';
import '../../models/order_data.dart';

class Order extends StatelessWidget {
  final Security security;
  final double price;

  Order({@required this.security, this.price});

  static final tabs = [
    Tab(text: 'ЛИМИТ'),
    Tab(text: 'МАРКЕТ'),
    Tab(text: 'СТОП'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text(security.name),
          bottom: TabBar(tabs: tabs),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: TabBarView(
              children: [
                OrderForm(
                  security: security,
                  orderType: OrderType.limit,
                  price: price
                ),
                OrderForm(
                  security: security,
                  orderType: OrderType.market,
                  price: price
                ),
                OrderForm(
                  security: security,
                  orderType: OrderType.stop,
                  price: price
                ),
              ],
            )
          )
        ) 
      ),
    );
  }
}