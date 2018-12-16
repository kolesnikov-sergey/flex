import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:fl/models/security.dart';

List<Security> parseSecurities(String responseBody) {
  final securities = json.decode(responseBody)[1]['securities'][1];
  final marketdata = json.decode(responseBody)[1]['marketdata'][1];

  final result = List<Security>();

  for (var i = 0; i < securities.length; i++) {
    final sec = securities[i];
    sec['marketdata'] = marketdata[i];
    final security = Security.fromJson(sec);
    result.add(security);
  }

  return result;
}

const iisHost = 'iss.moex.com';

Future<List<Security>> fetchSecurities() async {
  final engine = 'stock';
  final market = 'shares';
  final board = 'TQBR';

  final query = {
    'iss.json': 'extended',
    'sort_column': 'VALTODAY',
    'sort_order': 'desc',
    'first': '30'
  };

  final uri = Uri.https(
    iisHost,
    'iss/engines/$engine/markets/$market/boards/$board/securities.json',
    query
  );

  final response = await http.get(uri);

  if(response.statusCode != 200) {
    throw new Exception('request error, code: ${response.statusCode}');
  }

  return compute(parseSecurities, response.body);
}
