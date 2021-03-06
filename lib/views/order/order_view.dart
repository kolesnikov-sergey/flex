import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'buy_sell_info.dart';
import 'order_form.dart';
import '../../models/order.dart';
import '../../models/layout_type.dart';
import '../../state/securities_state.dart';
import '../../state/quotes_state.dart';

class OrderView extends StatefulWidget {
  final double price;

  OrderView({this.price});

  static final tabs = [
    Tab(text: 'МАРКЕТ'),
    Tab(text: 'ЛИМИТ'),
    Tab(text: 'СТОП'),
  ];

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final _securitiesState = GetIt.I<SecuritiesState>();
  final _quotesState = GetIt.I<QuotesState>();
  VoidCallback _unconnect;

   @override
  void initState() {
    _unconnect = _quotesState.connectQuote(_securitiesState.current.id);
    super.initState();
  }

  @override
  void dispose() {
    if (_unconnect != null) {
      _unconnect();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: OrderView.tabs.length,
      initialIndex: 1,
      child: Observer(
        builder: (_) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: Provider.of<LayoutType>(context) == LayoutType.mobile,
            title: Text(_securitiesState.current.name),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuySellInfo(
                    security: _securitiesState.current,
                    quote: _quotesState.quotes[_securitiesState.current.id],
                  ),
                  TabBar(tabs: OrderView.tabs)
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              OrderForm(
                security: _securitiesState.current,
                orderType: OrderType.market,
                price: widget.price
              ),
              OrderForm(
                security: _securitiesState.current,
                orderType: OrderType.limit,
                price: widget.price
              ),
              OrderForm(
                security: _securitiesState.current,
                orderType: OrderType.stop,
                price: widget.price
              ),
            ],
          ) 
        ),
      ),
    );
  }
}