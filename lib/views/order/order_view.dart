import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'buy_sell_info.dart';
import 'order_form.dart';
import '../../models/security.dart';
import '../../models/order.dart';

class OrderView extends StatelessWidget {
  final Security security;
  final double price;

  OrderView({@required this.security, this.price});

  static final tabs = [
    Tab(text: 'МАРКЕТ'),
    Tab(text: 'ЛИМИТ'),
    Tab(text: 'СТОП'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text(security.name),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuySellInfo(security: security),
                TabBar(tabs: tabs)
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            OrderForm(
              security: security,
              orderType: OrderType.market,
              price: price
            ),
             OrderForm(
              security: security,
              orderType: OrderType.limit,
              price: price
            ),
            OrderForm(
              security: security,
              orderType: OrderType.stop,
              price: price
            ),
          ],
        ) 
      ),
    );
  }
}