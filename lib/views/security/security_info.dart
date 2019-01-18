import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'chart_info.dart';
import 'summary.dart';
import '../../models/security.dart';
import '../../connectors/connector.dart';

class SecurityInfo extends StatelessWidget {
  final Security security;
  final SecurityType securityType;
  final Connector connector;

  SecurityInfo({
    @required this.security,
    @required this.securityType,
    @required this.connector
  });

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
          leading: BackButton(),
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
          children: [
            ChartInfo(
              connector: connector,
              security: security,
              securityType: securityType,
            ),
            Summary(),
            Center(
              child: Text('Стакан'),
            )
          ]
        )
      )
    );
  }
}
