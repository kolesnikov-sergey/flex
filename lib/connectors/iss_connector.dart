import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/security.dart';
import '../models/quote.dart';
import '../models/candle.dart';

class IssConnector {
  final String _issHost = 'iss.moex.com';

  final List<String> _subscribedQuotes = List<String>();

  Stream<Quote> _quotes;

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
      'first': '30',
      'securities.columns': 'SECID,SHORTNAME,DECIMALS',
      'marketdata.columns': 'LAST,CHANGE'
    };

    final uri = Uri.https(
      _issHost,
      'iss/engines/$engine/markets/$market/boards/$board/securities.json',
      query
    );

    final response = await http.get(uri);

    if(response.statusCode != 200) {
      throw new Exception('request error, code: ${response.statusCode}');
    }

    var securities = await compute(_parseSecurities, response.body);

    return securities;
  }

  Stream<Quote> subscribeQuote(String id) {
    _subscribedQuotes.add(id);
    return _quotes.where((q) => q.id == id);
  }

  void unsubscribeQuote(String id) {
    _subscribedQuotes.remove(id);
  }

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

    final response = await http.get(uri);

    if(response.statusCode != 200) {
      throw new Exception('request error, code: ${response.statusCode}');
    }

    return await compute(_parseQuotes, response.body);
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

    final response = await http.get(uri);

    if(response.statusCode != 200) {
      throw new Exception('request error, code: ${response.statusCode}');
    }

    return await compute(_parseCandles, response.body);
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
}