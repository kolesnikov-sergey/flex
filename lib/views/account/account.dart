import 'package:flutter/material.dart';

import 'account_info.dart';
import 'positions.dart';
import 'orders.dart';
import 'trades.dart';
import '../ui/flex_drawer.dart';
import '../../models/market.dart';
import '../../models/layout_type.dart';

class Account extends StatelessWidget {
  static final markets = {
    Market.stock: 'Фондовый рынок',
    Market.currency: 'Валютный рынок',
    Market.derivative: 'Срочный рынок',
  };

  static final tabs = [
    Tab(text: 'ПОЗИЦИИ'),
    Tab(text: 'ЗАЯВКИ'),
    Tab(text: 'СДЕЛКИ')
  ];

  Account({
    this.layoutType,
  });

  final LayoutType layoutType;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        drawer: FlexDrawer(
          title: 'Рынок',
          options: markets,
          value: Market.stock,
          onChange: (market) {},
        ),
        appBar: AppBar(
          title: Text(markets[Market.stock]),
          bottom: layoutType == LayoutType.mobile
            ? PreferredSize(
                preferredSize: Size.fromHeight(120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AccountInfo(),
                    TabBar(tabs: tabs)
                  ],
                ),
              )
            : null
        ),
        body: TabBarView(
          children: [
            Positions(),
            Orders(),
            Trades()
          ],
        ),
      ),
    );
  }
}