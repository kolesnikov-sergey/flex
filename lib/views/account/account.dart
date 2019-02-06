import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../ui/flex_dropdown.dart';
import '../ui/number_currency.dart';
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Row(
                    mainAxisAlignment: Theme.of(context).platform == TargetPlatform.iOS
                      ? MainAxisAlignment.center :  MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      NumberCurrency(
                        value: 100000.34,
                        currency: 'RUB',
                        style: Theme.of(context).textTheme.title,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      NumberCurrency(
                        value: 100.78,
                        currency: 'RUB',
                        prefix: '+',
                        style: Theme.of(context).textTheme.subtitle.apply(color: Colors.green),
                      ),
                    ],
                  ),
                ),
                TabBar(tabs: tabs)
              ],
            ),
          ),
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