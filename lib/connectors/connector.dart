import 'dart:async';

import '../models/security.dart';
import '../models/quote.dart';
import '../models/candle.dart';
import '../models/position.dart';
import '../models/order_data.dart';

abstract class Connector {
  Future<List<Security>> getSecurities();

  Future<List<Candle>> getCandles(String id);

  Future<void> createOrder(OrderData order);

  Stream<Quote> subscribeQuote(String id);
  void unsubscribeQuote(String id);

  Stream<Position> subscribePositions();
  void unsubscribePositions();
}