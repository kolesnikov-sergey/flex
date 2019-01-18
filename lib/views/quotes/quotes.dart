import 'package:flutter/material.dart';

import '../../models/security.dart';
import '../../connectors/connector.dart';
import 'tabs_app_bar.dart';
import 'quotes_list.dart';

class Quotes extends StatelessWidget {
  final Connector connector;

  Quotes({@required this.connector});

  final securityTypes = {
    SecurityType.shares: 'АКЦИИ',
    SecurityType.bonds: 'ОБЛИГАЦИИ',
    SecurityType.currencies: 'ВАЛЮТА',
    SecurityType.futures: 'ФЬЮЧЕРСЫ'
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: securityTypes.length,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: TabsAppBar(
          tabs: securityTypes.values.map((tab) => Tab(text: tab)).toList()
        ),
        body: TabBarView(
          children: securityTypes.keys.map((securityType) {
            return QuotesList(
              connector: connector,
              securityType: securityType,
            );
          }).toList()
        )
      )
    );
  }
}
