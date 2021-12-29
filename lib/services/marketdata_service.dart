import 'package:flex/models/quote.dart';

abstract class MarketdataService {
  Stream<Quote> subscribeQuotes(List<String> ids);
}