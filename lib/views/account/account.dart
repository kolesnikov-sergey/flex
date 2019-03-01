import 'package:flutter/material.dart';

import '../ui/flex_dropdown.dart';
import 'account_info.dart';
import 'positions.dart';
import 'orders.dart';
import 'trades.dart';
import '../../models/market.dart';

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: FlexDropdown(
            initialValue: Market.stock,
            items: markets,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AccountInfo(),
                TabBar(tabs: tabs)
              ],
            ),
          ),
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