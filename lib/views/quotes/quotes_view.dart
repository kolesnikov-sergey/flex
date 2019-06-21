import 'package:flutter/material.dart';

import '../../models/security.dart';
import '../security/security_view.dart';
import 'quotes_list.dart';
import 'quotes_full.dart';

class QuotesView extends StatelessWidget {
  static final securityTypes = {
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
          return QuotesFull();
        } else {
          return QuotesList(
            onPressed: (security, type) {
              Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) => SecurityView(
                  security: security,
                  securityType: type,
                )
              ));
            }
          );
        }
      }
    );
  }
}
