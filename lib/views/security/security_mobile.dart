import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'chart/chart_view.dart';
import 'summary.dart';
import 'order_book/order_book_view.dart';
import '../../state/securities_state.dart';

class SecurityMobile extends StatefulWidget {
  SecurityMobile({
    Key? key,
  }) : super(key: key);

  @override
  _SecurityMobileState createState() => _SecurityMobileState();
}

class _SecurityMobileState extends State<SecurityMobile> {
  final _tabs = [
    Tab(text: 'ГРАФИК'),
    Tab(text: 'СВОДКА'),
    Tab(text: 'СТАКАН')
  ];

  final _securitiesState = GetIt.I<SecuritiesState>();

  void _navigateToOrder(double? price) {
    Navigator.pushNamed(context, '/order');
  }

  @override
  Widget build(BuildContext context) {
    final currentSecurity = _securitiesState.current;

    return DefaultTabController(
      length: _tabs.length,
      initialIndex: 0,
      child: Observer(
        builder: (_) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: BackButton(),
            title: Text(_securitiesState.current?.name ?? ''),
            bottom: TabBar(tabs: _tabs),
            actions: [
              IconButton(
                icon: Icon(Icons.star_border),
                onPressed: () {},
              )
            ]
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: currentSecurity == null ? [] : [
              ChartView(
                security: currentSecurity,
                securityType: _securitiesState.securityType,
                onAddOrder: _navigateToOrder,
              ),
              Summary(
                security: currentSecurity,
                onAddOrder: _navigateToOrder,
              ),
              OrderBookView(
                security: currentSecurity,
                securityType:  _securitiesState.securityType,
                onAddOrder: _navigateToOrder,
              )
            ]
          )
        ),
      )
    );
  }
}
