import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import '../../../models/order_book.dart';
import '../../../models/security.dart';
import '../../../connectors/connector.dart';
import '../../../connectors/connector_factory.dart';
import '../../ui/flex_future_builder.dart';
import 'order_book_box.dart';

class OrderBookView extends StatefulWidget {
  final Security security;
  final SecurityType securityType;
  final ValueChanged<double> onAddOrder;

  OrderBookView({
    @required this.security,
    @required this.securityType,
    @required this.onAddOrder
  });

  @override
  _OrderBookState createState() => _OrderBookState();
}

class _OrderBookState extends State<OrderBookView> {
  final Connector connector = ConnectorFactory.getConnector();

  Future<List<OrderBook>> orderBook;

  @override
  void initState() {
    orderBook = connector.getOrderBook(widget.security.id, widget.securityType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlexFutureBuilder<List<OrderBook>>(
      future: orderBook,
      onRetry: () {},
      builder: (context, snapshot) {
        final maxBuy = snapshot.data
          .where((t) => t.buy != null)
          .map((t) => t.buy)
          .reduce(max);
        final maxSell = snapshot.data
          .where((t) => t.sell != null)
          .map((t) => t.sell)
          .reduce(max);

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            var item = snapshot.data[index];

            return GestureDetector(
              onTap: () => widget.onAddOrder(item.price),
              child: Row(
                children: [
                  OrderBookBox(
                    value: item.buy,
                    alignment: Alignment.centerLeft,
                    decimals: 0,
                    color: item.buy == null ? null : Colors.green,
                    widthFactor: item.buy == null ? 0 : item.buy / maxBuy,
                  ),
                  OrderBookBox(
                    value: item.price,
                    alignment: Alignment.center,
                    decimals: widget.security.decimals,
                    border: true,
                  ),
                  OrderBookBox(
                    value: item.sell,
                    alignment: Alignment.centerRight,
                    decimals: 0,
                    color: item.sell == null ? null : Colors.pink,
                    widthFactor: item.sell == null ? 0 : item.sell / maxSell,
                  )
                ]
              ),
            );
          },
        );
      }
    );
  }
}