import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'chart/chart_view.dart';
import 'summary.dart';
import 'order_book/order_book_view.dart';
import '../order/order_view.dart';
import '../../models/security.dart';

class SecurityView extends StatelessWidget {
  final Security security;
  final SecurityType securityType;
  final bool showBackButton;

  SecurityView({
    Key key,
    @required this.security,
    @required this.securityType,
    this.showBackButton = true
  }) : super(key: key);

  final tabs = [
    Tab(text: 'ГРАФИК'),
    Tab(text: 'СВОДКА'),
    Tab(text: 'СТАКАН')
  ];

  @override
  Widget build(BuildContext context) {
    final navigateToOrder = (double price) {
      Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) => OrderView(security: security, price: price)
      ));
    };

    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          leading: showBackButton ? BackButton() : null,
          title: Text(security.name),
          bottom: TabBar(tabs: tabs),
          actions: [
            IconButton(
              icon: Icon(Icons.star_border),
              onPressed: () {},
            )
          ]
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            ChartView(
              security: security,
              securityType: securityType,
              onAddOrder: navigateToOrder,
            ),
            Summary(
              security: security,
              onAddOrder: navigateToOrder,
            ),
            OrderBookView(
              security: security,
              securityType: securityType,
              onAddOrder: navigateToOrder,
            )
          ]
        )
      )
    );
  }
}
