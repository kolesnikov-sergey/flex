import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../ui/flex_dropdown.dart';
import 'positions.dart';
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
            onSelected: (market) {},
          ),
          bottom: TabBar(tabs: tabs),
        ),
        body: TabBarView(
          children: [
            Positions(),
            Center(
              child: Text('Заявки'),
            ),
            Center(
              child: Text('Сделки'),
            )
          ],
        ),
      ),
    );
  }
}