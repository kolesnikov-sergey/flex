import 'dart:async';

import '../models/security.dart';
import '../models/quote.dart';
import '../models/candle.dart';
import '../models/position.dart';
import '../models/order_data.dart';
import '../models/order_book_item.dart';

abstract class Connector {
  Future<List<Security>> getSecurities(SecurityType type);

  Future<List<Candle>> getCandles(String id, SecurityType type);

  Future<void> createOrder(OrderData order);

  Stream<Quote> subscribeQuote(String id);
  void unsubscribeQuote(String id);

  Stream<Position> subscribePositions();
  void unsubscribePositions();

  Future<List<OrderBookItem>> getOrderBook(String id, SecurityType type);
}