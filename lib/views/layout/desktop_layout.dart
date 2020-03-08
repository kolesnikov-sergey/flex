import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../state/securities_state.dart';
import '../security/security_view.dart';
import '../quotes/quotes_view.dart';
import '../account/account.dart';
import '../../models/layout_type.dart';

class DesktopLayout extends StatefulWidget {
  @override
  _DesktopLayoutState createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  final _securitiesState = GetIt.I<SecuritiesState>();

  @override
  Widget build(BuildContext context) {
    final rightWidget = _securitiesState.current == null
      ? Scaffold(
        key: ValueKey('empty'),
        appBar: AppBar(),
        body: Center(
          child: Text('Выберите инструмент', style: Theme.of(context).textTheme.display1),
        )
      ) 
      : SecurityView(
        key: ValueKey(_securitiesState.current.id),
        security: _securitiesState.current,
        securityType: _securitiesState.securityType,
        layoutType: LayoutType.desktop,
      );

    return Observer(
      builder: (_) => Row(
        children: [
          Container(
            width: 300,
            child: QuotesView(
              onPressed: _securitiesState.setCurrent,
              selectedItem: _securitiesState.current
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
      ),
    );
  }
}