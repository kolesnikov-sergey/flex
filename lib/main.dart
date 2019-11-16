import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/securities_state.dart';
import 'state/security_state.dart';
import 'views/layout/layout.dart';
import 'setup.dart';

void main() {
  setup();
  runApp(new TradingApp());
}

class TradingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accentColor = Colors.blue;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => SecuritiesState(),
        ),
        ChangeNotifierProvider(
          builder: (_) => SecurityState(),
        )
      ],
      child: MaterialApp(
        title: 'flex',
        theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: accentColor,
          brightness: Brightness.dark,
          toggleableActiveColor: accentColor,
          buttonColor: accentColor
        ),
        initialRoute: '/',
        routes: {
          '/' : (context) => Layout()
        },
      ),
    );
  }
}
