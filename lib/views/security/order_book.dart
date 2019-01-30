import 'dart:math';
import 'package:flutter/material.dart';

import '../../models/order_book_item.dart';

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
  @override
  _OrderBookState createState() => _OrderBookState();
}

class _OrderBookState extends State<OrderBook> {
  final testOrderBookData = [
    OrderBookItem(price: 12, buy: null, sell: 1),
    OrderBookItem(price: 11, buy: null, sell: 1),
    OrderBookItem(price: 10, buy: null, sell: 1),
    OrderBookItem(price: 9, buy: null, sell: 1),
    OrderBookItem(price: 8, buy: null, sell: 10),
    OrderBookItem(price: 7, buy: null, sell: 2),
    OrderBookItem(price: 6, buy: null, sell: 1),
    OrderBookItem(price: 5, buy: 5, sell: null),
    OrderBookItem(price: 4, buy: 4, sell: null),
    OrderBookItem(price: 3, buy: 3, sell: null),
    OrderBookItem(price: 2, buy: 2, sell: null),
    OrderBookItem(price: 1, buy: 2, sell: null)
  ];

  @override
  Widget build(BuildContext context) {
    final maxBuy = testOrderBookData
      .where((t) => t.buy != null)
      .map((t) => t.buy)
      .reduce(max);
    final maxSell = testOrderBookData
      .where((t) => t.sell != null)
      .map((t) => t.sell)
      .reduce(max);

    return ListView.builder(
        itemCount: testOrderBookData.length,
        itemBuilder: (context, index) {
          var item = testOrderBookData[index];

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
}