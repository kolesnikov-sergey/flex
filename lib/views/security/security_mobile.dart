import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../state/securities.dart';
import 'chart/chart_view.dart';
import 'summary.dart';
import 'order_book/order_book_view.dart';

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

  void _navigateToOrder(double? price) {
    Navigator.pushNamed(context, '/order');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: 0,
      child: BlocBuilder<SecuritiesCubit, SecuritiesState>(
        builder: (_, state) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: BackButton(),
            title: Text(state.current?.name ?? ''),
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
            children: state.current == null ? [] : [
              ChartView(
                security: state.current!,
                securityType: state.securityType,
                onAddOrder: _navigateToOrder,
              ),
              Summary(
                security: state.current!,
                onAddOrder: _navigateToOrder,
              ),
              OrderBookView(
                security: state.current!,
                securityType: state.securityType,
                onAddOrder: _navigateToOrder,
              )
            ]
          )
        ),
      )
    );
  }
}
