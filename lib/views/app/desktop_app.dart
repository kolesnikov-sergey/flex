import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../state/securities_state.dart';
import '../security/security_view.dart';
import '../quotes/quotes_view.dart';
import '../account/account.dart';
import '../../models/layout_type.dart';

class DesktopApp extends StatefulWidget {
  @override
  _DesktopAppState createState() => _DesktopAppState();
}

class _DesktopAppState extends State<DesktopApp> {
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
      : SecurityView();

    return Row(
      children: [
          Container(
            width: 300,
            child: QuotesView(
              layoutType: LayoutType.desktop,
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