import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state/securities.dart';
import 'chart/chart_view.dart';
import 'summary.dart';
import 'order_button.dart';
import 'order_book/order_book_view.dart';
import '../order/order_view.dart';

class SecurityDesktop extends StatefulWidget {
  SecurityDesktop({
    Key? key,
  }) : super(key: key);

  @override
  _SecurityDesktopState createState() => _SecurityDesktopState();
}

class _SecurityDesktopState extends State<SecurityDesktop> {
  final tabs = [
    Tab(text: 'СТАКАН'),
    Tab(text: 'СВОДКА'),
  ];

  void _showOrderDialog([double? price]) {
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
    return BlocBuilder<SecuritiesCubit, SecuritiesState>(
      builder: (_, state) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(state.current!.name),
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
                security: state.current!,
                securityType:  state.securityType,
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
                        security: state.current!,
                        securityType:  state.securityType,
                        onAddOrder: _showOrderDialog,
                      ),
                      Summary(
                        security: state.current!,
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
