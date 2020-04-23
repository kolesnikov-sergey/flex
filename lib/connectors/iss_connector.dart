import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'connector.dart';
import '../models/security.dart';
import '../models/quote.dart';
import '../models/candle.dart';
import '../models/order.dart';
import '../models/position.dart';
import '../models/order_book.dart';

typedef T ParseFn<T>(String body);

class IssConnector implements Connector {
  final String _issHost = 'iss.moex.com';

  final _startedPositions = [
    Position(id: 'SBER', name: 'Сбербанк', qty: 10),
    Position(id: 'LKOH', name: 'ЛУКОЙЛ', qty: 20),
    Position(id: 'GAZP', name: 'ГАЗПРОМ ао', qty: 5)
  ];

  Future<List<Security>> getSecurities(SecurityType type) async {
    final engine = _getEngineBySecurityType(type);
    final market = _getMarketBySecurityType(type);
    final board = _getBoardBySecurityType(type);

    final query = {
      'iss.meta': 'off',
      'iss.json': 'extended',
      'sort_column': 'VALTODAY',
      'sort_order': 'desc',
      'securities.columns': 'SECID,SHORTNAME,DECIMALS,MINSTEP,CURRENCYID,LOTSIZE,FACEVALUE',
      'marketdata.columns': 'OPEN,LAST,HIGH,LOW,BID,OFFER,VALTODAY,CHANGE'
    };

    final uri = Uri.https(
      _issHost,
      'iss/engines/$engine/markets/$market/boards/$board/securities.json',
      query
    );

    return _get(uri, _parseSecurities);
  }

  Stream<Quote> subscribeQuotes(List<String> ids) {
    return Stream.periodic(Duration(seconds: 5))
      .asyncMap<List<Quote>>((time) => getQuotes(ids))
      .expand((quote) {
        return quote;
      });
  }

  Stream<Position> subscribePositions() {
    StreamController<Position> controller;
    Timer timer;
    controller = StreamController<Position>(
      onListen: () {
        timer = Timer(Duration(milliseconds: 100), () {
          _startedPositions.forEach((pos) {
            controller.add(pos);
          });
        });
      },
      onCancel: () {
        timer.cancel();
        controller.close();
      }
    );

    return controller.stream;
  }

  Future<List<Quote>> getQuotes(List<String> ids) async {
    //todo fix
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

    var res = await _get(uri, _parseQuotes);

    return res;
  }

  Future<List<Candle>> getCandles(String id, SecurityType type) async {
    final engine = _getEngineBySecurityType(type);
    final market = _getMarketBySecurityType(type);

    final query = {
      'iss.meta': 'off',
      'iss.json': 'extended',
      'from': '2016-01-01',
      'interval': '7'
    };

    final uri = Uri.https(
      _issHost,
      'iss/engines/$engine/markets/$market/securities/$id/candles.json',
      query
    );

    return _get(uri, _parseCandles);
  }

  Future<List<OrderBook>> getOrderBook(String id, SecurityType type) async {
    final engine = _getEngineBySecurityType(type);
    final market = _getMarketBySecurityType(type);
    final board = _getBoardBySecurityType(type);

    final query = {
      'iss.meta': 'off',
      'iss.json': 'extended',
      'securities.columns': 'SECID,MINSTEP',
      'marketdata.columns': 'LAST,MINSTEP',
    };

    final uri = Uri.https(
      _issHost,
      'iss/engines/$engine/markets/$market/boards/$board/securities/$id.json',
      query
    );

    final securities = await _get(uri, _parseSecurities);
    final security = securities[0];

    return Iterable<int>.generate(16, (i) => 8 - i)
      .where((i) => i != 0)
      .map((i) => OrderBook(
        price: security.last + i * security.minStep,
        buy: i < 0 ? i.abs() : null,
        sell: i >= 0 ? i : null
      ))
      .toList();
  }

  Future<void> createOrder(Order order) async {
    await Future.delayed(Duration(seconds: 1));
    final current = _startedPositions.firstWhere((pos) => pos.id == order.id, orElse: () => null);

    if(current != null) {
      current.qty = current.qty + ((order.side == OrderSide.buy ? 1 : -1) * order.qty);

      if(current.qty == 0) {
        _startedPositions.remove(current);
      }

      return;
    }
  
    final pos = Position(
      id: order.id,
      qty: ((order.side == OrderSide.buy ? 1 : -1) * order.qty),
      name: order.name
    );
    _startedPositions.add(pos);  
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

    // todo тут может возникать необработанное исключение
    return await compute(parse, response.body);
  }

  String _getEngineBySecurityType(SecurityType type) {
    switch(type) {
      case SecurityType.shares:
      case SecurityType.bonds:
        return 'stock';
      case SecurityType.currencies:
        return 'currency';
      case SecurityType.futures:
        return 'futures';
      default:
        return null;
    }
  }

  String _getMarketBySecurityType(SecurityType type) {
    switch(type) {
      case SecurityType.shares:
        return 'shares';
      case SecurityType.bonds:
        return 'bonds';
      case SecurityType.currencies:
        return 'selt';
      case SecurityType.futures:
        return 'forts';
      default:
        return null;
    }
  }

  String _getBoardBySecurityType(SecurityType type) {
    switch(type) {
      case SecurityType.shares:
        return 'TQBR';
      case SecurityType.bonds:
        return 'EQOB';
      case SecurityType.currencies:
        return 'CETS';
      case SecurityType.futures:
        return 'RFUD';
      default:
        return null;
    }
  }

  void dispose() {}
}
