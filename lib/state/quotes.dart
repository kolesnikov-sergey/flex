import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/quote.dart';
import '../services/marketdata_service.dart';

class QuotesCubit extends Cubit<Map<String, Quote>> {
  final MarketdataService _marketdataService;

  QuotesCubit(this._marketdataService): super({});

  subscribe(String id) {
    final subscribtion = _marketdataService.subscribeQuotes([id]).listen((quote) {
      final Map<String, Quote> next = Map.from(state);
      next[quote.id] = quote;
      emit(next);
    });

    return () => subscribtion.cancel();
  }
}

class QuoteSelector extends BlocSelector<QuotesCubit, Map<String, Quote>, Quote?> {
  QuoteSelector({
    required BlocWidgetBuilder<Quote?> builder,
    required String securityId,
  }) : super(builder: builder, selector: (state) => state[securityId]);
}