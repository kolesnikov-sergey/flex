import 'package:flex/views/order/order_view.dart';
import 'package:flex/views/security/security_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/layout_type.dart';
import 'views/app/app.dart';
import 'setup.dart';

void main() {
  setup();
  runApp(new TradingApp());
}

class TradingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accentColor = Colors.blue;

    return MaterialApp(
      title: 'flex',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: accentColor,
        brightness: Brightness.dark,
        toggleableActiveColor: accentColor,
        buttonColor: accentColor
      ),
      builder: (context, child) {
        return LayoutBuilder(
          builder: (_, constraints) {
            return Provider.value(
              value: constraints.maxWidth > 600 ? LayoutType.desktop : LayoutType.mobile,
              child: child
            );
          },
        );
      },
      initialRoute: '/',
      routes: {
        '/' : (context) => App(),
        '/security': (context) => SecurityView(),
        '/order': (context) => OrderView(),
      },
    );
  }
}
