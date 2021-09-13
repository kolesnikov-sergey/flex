import 'package:mobx/mobx.dart';

import '../models/quote.dart';

part 'quote_state.g.dart';

class QuoteState = _QuoteState with _$QuoteState;

abstract class _QuoteState with Store {
  String id;

  @observable
  double last;

  @observable
  double bid;

  @observable
  double offer;

  @observable
  double spread;

  @observable
  double change;

  _QuoteState(Quote quote) :
    id = quote.id,
    last = quote.last,
    bid = quote.bid,
    offer = quote.offer,
    spread = quote.spread,
    change = quote.change;

  @action
  void update(Quote quote) {
    last = quote.last;
    bid = quote.bid;
    offer = quote.offer;
    spread = quote.spread;
    change = quote.change;
  }
}