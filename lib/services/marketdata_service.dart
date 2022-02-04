import '../models/quote.dart';

abstract class MarketdataService {
  Stream<Quote> subscribeQuotes(List<String> ids);
}