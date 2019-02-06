import 'dart:math';
import 'package:flutter/material.dart';

import '../../../models/order_book_item.dart';
import '../../../models/security.dart';
import '../../../connectors/connector.dart';
import '../../../connectors/connector_factory.dart';
import '../../order/order.dart';
import '../../ui/flex_future_builder.dart';
import 'order_book_box.dart';

class OrderBook extends StatefulWidget {
  final Security security;
  final SecurityType securityType;

  OrderBook({
    @required this.security,
    @required this.securityType,
  });

  @override
  _OrderBookState createState() => _OrderBookState();
}

class _OrderBookState extends State<OrderBook> {
  final Connector connector = ConnectorFactory.getConnector();

  Future<List<OrderBookItem>> orderBook;

  @override
  void initState() {
    orderBook = connector.getOrderBook(widget.security.id, widget.securityType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlexFutureBuilder<List<OrderBookItem>>(
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
              onTap: () {
                 Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context) => Order(
                    security: widget.security,
                    price: item.price,
                  )
                ));
              },
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