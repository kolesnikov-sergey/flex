import 'package:flutter/material.dart';

import '../../models/security.dart';
import '../../connectors/connector.dart';
import '../security/security_info.dart';
import 'quotes_left.dart';

class QuotesFull extends StatefulWidget {
  final Connector connector;

  QuotesFull({@required this.connector});

  @override
  _QuotesFullState createState() => _QuotesFullState();
}

class _QuotesFullState extends State<QuotesFull> {
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
          child: Text('Выберите бумагу'),
        )
      ) 
      : SecurityInfo(
        key: ValueKey(security.id),
        connector: widget.connector,
        security: security,
        securityType: securityType,
        showBackButton: false,
      );

    return Row(
      children: [
        Container(
          width: 300,
          child: QuotesLeft(
            connector: widget.connector,
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