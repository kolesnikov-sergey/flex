import 'package:flex/models/position.dart';
import 'package:flex/models/quote.dart';
import 'package:flex/services/marketdata_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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