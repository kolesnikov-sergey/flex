// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuotesState on QuotesStateBase, Store {
  final _$quotesAtom = Atom(name: 'QuotesStateBase.quotes');

  @override
  ObservableMap<String, QuoteState> get quotes {
    _$quotesAtom.context.enforceReadPolicy(_$quotesAtom);
    _$quotesAtom.reportObserved();
    return super.quotes;
  }

  @override
  set quotes(ObservableMap<String, QuoteState> value) {
    _$quotesAtom.context.conditionallyRunInAction(() {
      super.quotes = value;
      _$quotesAtom.reportChanged();
    }, _$quotesAtom, name: '${_$quotesAtom.name}_set');
  }

  final _$QuotesStateBaseActionController =
      ActionController(name: 'QuotesStateBase');

  @override
  Function connectQuote(String symbol) {
    final _$actionInfo = _$QuotesStateBaseActionController.startAction();
    try {
      return super.connectQuote(symbol);
    } finally {
      _$QuotesStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _onQuote(Quote quote) {
    final _$actionInfo = _$QuotesStateBaseActionController.startAction();
    try {
      return super._onQuote(quote);
    } finally {
      _$QuotesStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'quotes: ${quotes.toString()}';
    return '{$string}';
  }
}
