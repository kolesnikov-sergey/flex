import 'services/iss/iss_marketdata_service.dart';
import 'services/iss/iss_position_service.dart';
import 'setup.dart';
import 'state/positions.dart';
import 'state/quotes.dart';
import 'state/securities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'connectors/iss_connector.dart';
import 'models/layout_type.dart';
import 'views/app/app.dart';
import 'views/order/order_view.dart';
import 'views/security/security_mobile.dart';

void main() {
  setup();
  runApp(new TradingApp());
}

class TradingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accentColor = Colors.blueAccent;

    return MaterialApp(
      title: 'flex',
      theme: ThemeData(
        primaryColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.black12,
        ),
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
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => PositionsCubit(IssPositionService())),
                  BlocProvider(create: (context) => QuotesCubit(IssMarketdataService())),
                  BlocProvider(create: (context) => SecuritiesCubit(IssConnector()))
                ],
                child: child!,
              ),
            );
          },
        );
      },
      initialRoute: '/',
      routes: {
        '/' : (context) => App(),
        '/security': (context) => SecurityMobile(),
        '/order': (context) => OrderView(),
      },
    );
  }
}
