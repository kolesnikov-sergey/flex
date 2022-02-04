import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/quote.dart';
import '../../services/marketdata_service.dart';

typedef T ParseFn<T>(String body);

class IssMarketdataService extends MarketdataService {
  final String _host = 'iss.moex.com';
  
  Stream<Quote> subscribeQuotes(List<String> ids) {
    return Stream.periodic(Duration(seconds: 5))
      .asyncMap<List<Quote>>((time) => _getQuotes(ids))
      .expand((quote) {
        return quote;
      });
  }

  Future<List<Quote>> _getQuotes(List<String> ids) async {
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
      _host,
      'iss/engines/$engine/markets/$market/boards/$board/securities.json',
      query
    );

    var res = await _get(uri, _parseQuotes);

    return res;
  }

  static List<Quote> _parseQuotes(String body) {
    final marketdata = json.decode(body)[1]['marketdata'];
    return marketdata.map<Quote>((item) => Quote.fromJson(item)).toList();
  }

  Future<T> _get<T>(Uri uri, ParseFn<T> parse) async {
    final response = await http.get(uri);

    if(response.statusCode != 200) {
      throw new Exception('request error, code: ${response.statusCode}');
    }

    return parse(response.body);
  }
}