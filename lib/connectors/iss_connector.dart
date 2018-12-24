import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'connector.dart';
import '../models/security.dart';
import '../models/quote.dart';
import '../models/candle.dart';
import '../models/order_data.dart';
import '../models/position.dart';

typedef T ParseFn<T>(String body);

class IssConnector implements Connector {
  final String _issHost = 'iss.moex.com';

  final List<String> _subscribedQuotes = List<String>();

  Stream<Quote> _quotes;

  final _startedPositions = [
    Position(
      id: 'SBER',
      name: 'CБЕРБАНК',
      qty: 10
    )
  ];

  final StreamController<Position> _positionsController = StreamController<Position>();

  IssConnector() {
    _quotes = Stream.periodic(Duration(seconds: 10))
      .asyncMap<List<Quote>>((time) => _subscribedQuotes.length > 0 ? getQuotes(_subscribedQuotes) : [])
      .expand((quote) => quote)
      .asBroadcastStream();
  }

  Future<List<Security>> getSecurities() async {
    final engine = 'stock';
    final market = 'shares';
    final board = 'TQBR';

    final query = {
      'iss.meta': 'off',
      'iss.json': 'extended',
      'sort_column': 'VALTODAY',
      'sort_order': 'desc',
      'first': '50',
      'securities.columns': 'SECID,SHORTNAME,DECIMALS,MINSTEP',
      'marketdata.columns': 'LAST,CHANGE'
    };

    final uri = Uri.https(
      _issHost,
      'iss/engines/$engine/markets/$market/boards/$board/securities.json',
      query
    );

    return _get(uri, _parseSecurities);
  }

  Stream<Quote> subscribeQuote(String id) {
    _subscribedQuotes.add(id);
    return _quotes.where((q) => q.id == id);
  }

  void unsubscribeQuote(String id) {
    _subscribedQuotes.remove(id);
  }

  Stream<Position> subscribePositions() {
    _startedPositions.forEach((pos) {
      _positionsController.add(pos);
    });
    return _positionsController.stream;
  }

  void unsubscribePositions() {}

  Future<List<Quote>> getQuotes(List<String> ids) async {
    final engine = 'stock';
    final market = 'shares';
    final board = 'TQBR';

    final query = {
      'iss.meta': 'off',
      'iss.json': 'extended',
      'marketdata.columns': 'SECID,LAST,BID,OFFER,SPREAD,CHANGE',
      'securities': ids.join(',')
    };

    final uri = Uri.https(
      _issHost,
      'iss/engines/$engine/markets/$market/boards/$board/securities.json',
      query
    );

    return _get(uri, _parseQuotes);
  }

  Future<List<Candle>> getCandles(String id) async {
    final engine = 'stock';
    final market = 'shares';
    final board = 'TQBR';

    final query = {
      'iss.meta': 'off',
      'iss.json': 'extended',
      'from': '2018-01-01',
      'till': '2018-12-30',
      'interval': '7'
    };

    final uri = Uri.https(
      _issHost,
      'iss/engines/$engine/markets/$market/boards/$board/securities/$id/candles.json',
      query
    );

    return _get(uri, _parseCandles);
  }

  Future<void> createOrder(OrderData order) async {
    await Future.delayed(Duration(seconds: 1));
    _positionsController.add(Position(
      id: order.id,
      qty: order.qty,
      name: 'sdfsdf'
    ));
  }

  static List<Security> _parseSecurities(String responseBody) {
    final securities = json.decode(responseBody)[1]['securities'];
    final marketdata = json.decode(responseBody)[1]['marketdata'];

    final result = List<Security>();

    for (var i = 0; i < securities.length; i++) {
      final sec = securities[i];
      sec['marketdata'] = marketdata[i];
      final security = Security.fromJson(sec);
      result.add(security);
    }

    return result;
  }

  static List<Quote> _parseQuotes(String body) {
    final marketdata = json.decode(body)[1]['marketdata'];
    return marketdata.map<Quote>((item) => Quote.fromJson(item)).toList();
  }

  static List<Candle> _parseCandles(String body) {
    final candles = json.decode(body)[1]['candles'];
    return candles.map<Candle>((item) => Candle.fromJson(item)).toList();
  }

  Future<T> _get<T>(Uri uri, ParseFn<T> parse) async {
    final response = await http.get(uri);

    if(response.statusCode != 200) {
      throw new Exception('request error, code: ${response.statusCode}');
    }

    return await compute(parse, response.body);
  }

  void dispose() {
    _positionsController.sink.close();
  }
}
