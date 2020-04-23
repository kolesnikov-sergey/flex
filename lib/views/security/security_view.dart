import 'package:flex/state/securities_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'chart/chart_view.dart';
import 'summary.dart';
import 'order_book/order_book_view.dart';
import '../order/order_view.dart';
import '../../models/layout_type.dart';

class SecurityView extends StatefulWidget {
  SecurityView({
    Key key,
  }) : super(key: key);

  @override
  _SecurityViewState createState() => _SecurityViewState();
}

class _SecurityViewState extends State<SecurityView> {
  final tabs = [
    Tab(text: 'ГРАФИК'),
    Tab(text: 'СВОДКА'),
    Tab(text: 'СТАКАН')
  ];

  final _securitiesState = GetIt.I<SecuritiesState>();

  void _navigateToOrder(double price) {
    final layoutType = Provider.of<LayoutType>(context);
    if (layoutType == LayoutType.mobile) {
      Navigator.pushNamed(context, '/order');
    } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Container(
              width: 400,
              height: 480, // TODO height by content
              child: OrderView()
            )
          )
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    final layoutType = Provider.of<LayoutType>(context);

    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Observer(
        builder: (_) => Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            leading: layoutType == LayoutType.mobile ? BackButton() : null,
            title: Text(_securitiesState.current.name),
            bottom: layoutType == LayoutType.mobile 
              ? TabBar(tabs: tabs)
              : null,
            actions: [
              IconButton(
                icon: Icon(Icons.star_border),
                onPressed: () {},
              )
            ]
          ),
          body: layoutType == LayoutType.mobile
            ? TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ChartView(
                    security: _securitiesState.current,
                    securityType: _securitiesState.securityType,
                    onAddOrder: _navigateToOrder,
                  ),
                  Summary(
                    security: _securitiesState.current,
                    onAddOrder: _navigateToOrder,
                  ),
                  OrderBookView(
                    security: _securitiesState.current,
                    securityType:  _securitiesState.securityType,
                    onAddOrder: _navigateToOrder,
                  )
                ]
              )
            : ChartView(
                security: _securitiesState.current,
                securityType:  _securitiesState.securityType,
                onAddOrder: _navigateToOrder,
              )
        ),
      )
    );
  }
}
