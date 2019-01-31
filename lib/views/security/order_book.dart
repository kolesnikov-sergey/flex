import 'dart:math';
import 'package:flutter/material.dart';

import '../../models/order_book_item.dart';
import '../../models/security.dart';
import '../../connectors/connector.dart';
import '../../connectors/connector_factory.dart';
import '../ui/flex_future_builder.dart';

class OrderBookBox extends StatelessWidget {
  final String value;
  final Alignment alignment;
  final Color color;
  final double widthFactor;
  final bool border;

  OrderBookBox({
    @required this.value,
    @required this.alignment,
    this.color,
    this.widthFactor = 0,
    this.border = false
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Align(
            alignment: alignment,
            child: FractionallySizedBox(
              widthFactor: widthFactor,
              alignment: alignment,
              child: Container(
                color: color,
                padding: EdgeInsets.all(15),
                child: Text('')
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            alignment: alignment,
            decoration: BoxDecoration(
              border: Border(
                left: border ? BorderSide(color: Colors.grey, width: 0.3) : BorderSide.none,
                right: border ? BorderSide(color: Colors.grey, width: 0.3) : BorderSide.none,
                bottom: BorderSide(color: Colors.grey, width: 0.3),
              ),
            ),
            child: Text(value ?? '-', style: TextStyle(fontWeight: FontWeight.bold))
          )

        ],
      )
    );
  }
}

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
  @override
  Widget build(BuildContext context) {

    return FlexFutureBuilder<List<OrderBookItem>>(
      future: connector.getOrderBook(widget.security.id, widget.securityType),
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

            return Row(
              children: [
                OrderBookBox(
                  value: item.buy?.toString(),
                  alignment: Alignment.centerLeft,
                  color: item.buy == null ? null : Colors.pink,
                  widthFactor: item.buy == null ? 0 : item.buy / maxBuy,
                ),
                OrderBookBox(
                  value: item.price.toString(),
                  alignment: Alignment.center,
                  border: true,
                ),
                OrderBookBox(
                  value: item.sell?.toString(),
                  alignment: Alignment.centerRight,
                  color: item.sell == null ? null : Colors.green,
                  widthFactor: item.sell == null ? 0 : item.sell / maxSell,
                )
              ]
            );
          }
        );
      }
    );
  }
}