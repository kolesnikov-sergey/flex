import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'chart/chart_view.dart';
import 'summary.dart';
import 'order_button.dart';
import 'order_book/order_book_view.dart';
import '../order/order_view.dart';
import '../../state/securities_state.dart';

class SecurityDesktop extends StatefulWidget {
  SecurityDesktop({
    Key key,
  }) : super(key: key);

  @override
  _SecurityDesktopState createState() => _SecurityDesktopState();
}

class _SecurityDesktopState extends State<SecurityDesktop> {
  final tabs = [
    Tab(text: 'СТАКАН'),
    Tab(text: 'СВОДКА'),
  ];

  final _securitiesState = GetIt.I<SecuritiesState>();
  

  void _showOrderDialog([double price]) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Container(
          width: 450,
          height: 520, // TODO height by content
          child: OrderView(
            price: price,
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_securitiesState.current.name),
              OrderButton(onPressed: _showOrderDialog),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.star_border),
              onPressed: () {},
            )
          ]
        ),
        body: Row(
          children: <Widget>[
            Flexible(
              child: ChartView(
                security: _securitiesState.current,
                securityType:  _securitiesState.securityType,
              ),
            ),
            Container(
              width: 350,
              child: DefaultTabController(
                length: tabs.length,
                initialIndex: 0,
                child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: TabBar(tabs: tabs),
                  ),
                  body: TabBarView(
                    children: [
                      OrderBookView(
                        security: _securitiesState.current,
                        securityType:  _securitiesState.securityType,
                        onAddOrder: _showOrderDialog,
                      ),
                      Summary(
                        security: _securitiesState.current,
                      ),
                    ]
                  ),
                ),
              )
            )
          ]
        ),
      )
    );
  }
}
