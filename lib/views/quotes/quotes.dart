import 'package:flutter/material.dart';

import '../../models/security.dart';
import '../../connectors/connector.dart';
import 'quotes_list.dart';

class Quotes extends StatelessWidget {
  final Connector connector;

  Quotes({@required this.connector});

  final securityTypes = {
    SecurityType.shares: 'Акции',
    SecurityType.bonds: 'Облигации',
    SecurityType.currencies: 'Валюта',
    SecurityType.futures: 'Фьючерсы'
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: securityTypes.length,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: TabBar(
            isScrollable: true,
            tabs: securityTypes.values.map((tab) {
              return Tab(text: tab);
            }).toList(),
          ),
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
