import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'chart/chart_view.dart';
import 'summary.dart';
import 'order_book/order_book_view.dart';
import '../order/order_view.dart';
import '../../models/security.dart';
import '../../models/layout_type.dart';

class SecurityView extends StatelessWidget {
  final Security security;
  final SecurityType securityType;
  final LayoutType layoutType;

  SecurityView({
    Key key,
    @required this.security,
    @required this.securityType,
    this.layoutType = LayoutType.mobile,
  }) : super(key: key);

  final tabs = [
    Tab(text: 'ГРАФИК'),
    Tab(text: 'СВОДКА'),
    Tab(text: 'СТАКАН')
  ];

  @override
  Widget build(BuildContext context) {
    final navigateToOrder = (double price) {
      if (layoutType == LayoutType.mobile) {
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) => OrderView(security: security, price: price)
        ));
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Container(
              width: 400,
              height: 480, // TODO height by content
              child: OrderView(security: security, price: price)
            )
          )
        );
      }
    };

    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          leading: layoutType == LayoutType.mobile ? BackButton() : null,
          title: Text(security.name),
          bottom: layoutType == LayoutType.mobile 
            ? TabBar(tabs: tabs)
            : null,
          actions: [
            IconButton(
              icon: Icon(Icons.star_border),
              onPressed: () {},
            )
          ]
        ),
        body: layoutType == LayoutType.mobile
          ? TabBarView(
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
          : ChartView(
              security: security,
              securityType: securityType,
              onAddOrder: navigateToOrder,
            )
      )
    );
  }
}
