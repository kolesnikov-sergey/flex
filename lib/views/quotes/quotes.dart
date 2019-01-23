import 'package:flutter/material.dart';

import '../../models/security.dart';
import '../../connectors/connector.dart';
import '../security/security_info.dart';
import 'quotes_list.dart';
import 'quotes_full.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > 600) {
          return QuotesFull(connector: connector);
        } else {
          return QuotesList(
            connector: connector,
            onPressed: (security, type) {
              Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) => SecurityInfo(
                  security: security,
                  securityType: type,
                  connector: connector
                )
              ));
            }
          );
        }
      }
    );
  }
}
