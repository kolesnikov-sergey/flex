import 'package:flutter/material.dart';

import '../../models/security.dart';
import '../security/security_view.dart';
import 'quotes_mobile_layout.dart';

class QuotesLargeLayout extends StatefulWidget {
  @override
  _QuotesLargeLayoutState createState() => _QuotesLargeLayoutState();
}

class _QuotesLargeLayoutState extends State<QuotesLargeLayout> {
  Security security;
  SecurityType securityType;

  void change(Security sec, SecurityType type) {
    setState(() {
      security = sec;
      securityType = type;  
    });
  }

  @override
  Widget build(BuildContext context) {
    final rightWidget = security == null
      ? Scaffold(
        key: ValueKey('empty'),
        appBar: AppBar(),
        body: Center(
          child: Text('Выберите инструмент', style: Theme.of(context).textTheme.display1),
        )
      ) 
      : SecurityView(
        key: ValueKey(security.id),
        security: security,
        securityType: securityType,
        showBackButton: false,
      );

    return Row(
      children: [
        Container(
          width: 300,
          child: QuotesMobileLayout(
            onPressed: change,
            selectedItem: security
          ),
        ),
        Container(
          width: 1,
          color: Theme.of(context).primaryColor,
        ),
        Flexible(
          flex: 3,
          child: rightWidget
        )
      ],
    );
  }
}