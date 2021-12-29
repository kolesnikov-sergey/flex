import 'package:flex/state/securities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../security/security_desktop.dart';
import '../quotes/quotes_view.dart';
import '../account/account.dart';

class DesktopApp extends StatefulWidget {
  @override
  _DesktopAppState createState() => _DesktopAppState();
}

class _DesktopAppState extends State<DesktopApp> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
          Container(
            width: 300,
            child: QuotesView(),
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
                  child: BlocBuilder<SecuritiesCubit, SecuritiesState>(
                    builder: (_, state) {
                      return state.current == null
                        ? Scaffold(
                          key: ValueKey('empty'),
                          appBar: AppBar(),
                          body: Center(
                            child: Text('Выберите инструмент', style: Theme.of(context).textTheme.headline6),
                          )
                        ) 
                        : SecurityDesktop();
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