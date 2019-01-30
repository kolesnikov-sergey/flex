import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'chart_info.dart';
import 'summary.dart';
import 'order_book.dart';
import '../../models/security.dart';
import '../../connectors/connector.dart';

class SecurityInfo extends StatelessWidget {
  final Security security;
  final SecurityType securityType;
  final Connector connector;
  final bool showBackButton;

  SecurityInfo({
    Key key,
    @required this.security,
    @required this.securityType,
    @required this.connector,
    this.showBackButton = true
  }) : super(key: key);

  final tabs = [
    Tab(text: 'ГРАФИК'),
    Tab(text: 'СВОДКА'),
    Tab(text: 'СТАКАН')
  ];

  @override
  Widget build(BuildContext context) {
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
            ChartInfo(
              connector: connector,
              security: security,
              securityType: securityType,
            ),
            Summary(),
            OrderBook()
          ]
        )
      )
    );
  }
}
