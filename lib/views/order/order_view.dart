import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'buy_sell_info.dart';
import 'order_form.dart';
import '../../state/securities.dart';
import '../../state/quotes.dart';
import '../../models/order.dart';
import '../../models/layout_type.dart';

class OrderView extends StatefulWidget {
  final double? price;

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
  Function? _unconnect;

   @override
  void initState() {
    final cubit = context.read<SecuritiesCubit>();
    final securiryId = cubit.state.current?.id;
    if (securiryId != null) {
      final quotesCubit = context.read<QuotesCubit>();
      _unconnect = quotesCubit.subscribe(securiryId);
    }
    
    super.initState();
  }

  @override
  void dispose() {
    if (_unconnect != null) {
      _unconnect!();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: OrderView.tabs.length,
      initialIndex: 1,
      child: BlocBuilder<SecuritiesCubit, SecuritiesState>(
        builder: (_, state) {
          final security = state.current!;

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: Provider.of<LayoutType>(context) == LayoutType.mobile,
              title: Text(security.name),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QuoteSelector(
                      securityId: security.id,
                      builder: (context, state) => BuySellInfo(
                        security: security,
                        quote: state,
                      )
                    ),
                    TabBar(tabs: OrderView.tabs)
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: [
                OrderForm(
                  security: security,
                  orderType: OrderType.market,
                  price: widget.price
                ),
                OrderForm(
                  security: security,
                  orderType: OrderType.limit,
                  price: widget.price
                ),
                OrderForm(
                  security: security,
                  orderType: OrderType.stop,
                  price: widget.price
                ),
              ],
            ) 
          );
        },
      ),
    );
  }
}