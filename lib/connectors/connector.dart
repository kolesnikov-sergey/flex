import 'dart:async';

import '../models/security.dart';
import '../models/quote.dart';
import '../models/candle.dart';
import '../models/position.dart';
import '../models/order.dart';
import '../models/order_book.dart';

abstract class Connector {
  Future<List<Security>> getSecurities(SecurityType type);

  Future<List<Candle>> getCandles(String id, SecurityType type);

  Future<void> createOrder(Order order);

  Stream<Quote> subscribeQuote(String id);
  void unsubscribeQuote(String id);

  Stream<Position> subscribePositions();
  void unsubscribePositions();

  Future<List<OrderBook>> getOrderBook(String id, SecurityType type);
}