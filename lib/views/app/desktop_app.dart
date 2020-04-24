import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../state/securities_state.dart';
import '../security/security_view.dart';
import '../quotes/quotes_view.dart';
import '../account/account.dart';

class DesktopApp extends StatefulWidget {
  @override
  _DesktopAppState createState() => _DesktopAppState();
}

class _DesktopAppState extends State<DesktopApp> {
  final _securitiesState = GetIt.I<SecuritiesState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
          Container(
            width: 300,
            child: QuotesView(),
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
          ),
          Flexible(
            flex: 3,
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Observer(
                    builder: (_) {
                      return _securitiesState.current == null
                        ? Scaffold(
                          key: ValueKey('empty'),
                          appBar: AppBar(),
                          body: Center(
                            child: Text('Выберите инструмент', style: Theme.of(context).textTheme.display1),
                          )
                        ) 
                        : SecurityView();
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Account(),
                )
              ],
            )
          )
        ],
    );
  }
}