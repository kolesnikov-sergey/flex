import 'package:flutter/material.dart';

import '../../models/security.dart';
import '../../connectors/connector.dart';
import 'tabs_app_bar.dart';
import 'quotes_list.dart';
import 'quote_item.dart';

class QuotesLeft extends StatelessWidget {
  final Connector connector;
  final SecurityCallback onPressed;
  final Security selectedItem;

  QuotesLeft({@required this.connector, @required this.onPressed, this.selectedItem});

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
              onPressed: onPressed,
              selectedItem: selectedItem,
            );
          }).toList()
        )
      )
    );
  }
}