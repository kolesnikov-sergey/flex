import 'package:flex/models/layout_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../security/security_view.dart';
import '../quotes/quotes_view.dart';
import '../account/account.dart';
import '../../state/security_state.dart';

class DesktopLayout extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    final securityState = Provider.of<SecurityState>(context);
    final security = securityState.getSecurity();
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
        securityType: securityState.getSecurityType(),
        layoutType: LayoutType.desktop,
      );

    return Row(
      children: [
        Container(
          width: 300,
          child: QuotesView(
            onPressed: securityState.setSecurity,
            selectedItem: security
          ),
        ),
        Container(
          width: 1,
          color: Theme.of(context).primaryColor,
        ),
        Flexible(
          flex: 3,
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: rightWidget,
              ),
              Flexible(
                flex: 1,
                child: Account(
                  layoutType: LayoutType.desktop,
                ),
              )
            ],
          )
        )
      ],
    );
  }
}