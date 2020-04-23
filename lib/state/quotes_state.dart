import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../connectors/connector.dart';
import '../models/quote.dart';
import '../tools/throttle.dart';
import 'quote_state.dart';

part 'quotes_state.g.dart';

class QuotesState = QuotesStateBase with _$QuotesState;

abstract class QuotesStateBase with Store {
  final _connector = GetIt.I<Connector>();

  StreamSubscription<Quote> sub;

  final Map<String, int> _symbols = {};

  Function _resubscribeThrottled;

  QuotesStateBase() {
    _resubscribeThrottled = throttle(500, _resubscribe);
  }

  @observable
  ObservableMap<String, QuoteState> quotes = ObservableMap();

  @action
  Function connectQuote(String symbol) {
    final connectCount = _symbols[symbol];

    if (connectCount == null) {
      _symbols[symbol] = 1;
    } else {
      _symbols[symbol] = connectCount + 1;
    }

    _resubscribeThrottled();

    return () {
      final connectCount = _symbols[symbol];
      if (connectCount == 1) {
        _symbols.remove(symbol);
      } else {
        _symbols[symbol] = connectCount - 1;
      }
    };
  }
  
  void _resubscribe() {
    sub?.cancel();

    if (_symbols.isEmpty) {
      return;
    }

    sub = _connector.subscribeQuotes(_symbols.keys.toList()).listen(_onQuote);
  }

  @action
  void _onQuote(Quote quote) {
    final prevQuote = quotes[quote.id];
    
    if (prevQuote == null) {
      quotes[quote.id] = QuoteState(quote);
    } else {
      prevQuote.update(quote);
    }
  }
}