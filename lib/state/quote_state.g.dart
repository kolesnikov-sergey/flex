// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuoteState on _QuoteState, Store {
  final _$lastAtom = Atom(name: '_QuoteState.last');

  @override
  double get last {
    _$lastAtom.context.enforceReadPolicy(_$lastAtom);
    _$lastAtom.reportObserved();
    return super.last;
  }

  @override
  set last(double value) {
    _$lastAtom.context.conditionallyRunInAction(() {
      super.last = value;
      _$lastAtom.reportChanged();
    }, _$lastAtom, name: '${_$lastAtom.name}_set');
  }

  final _$bidAtom = Atom(name: '_QuoteState.bid');

  @override
  double get bid {
    _$bidAtom.context.enforceReadPolicy(_$bidAtom);
    _$bidAtom.reportObserved();
    return super.bid;
  }

  @override
  set bid(double value) {
    _$bidAtom.context.conditionallyRunInAction(() {
      super.bid = value;
      _$bidAtom.reportChanged();
    }, _$bidAtom, name: '${_$bidAtom.name}_set');
  }

  final _$offerAtom = Atom(name: '_QuoteState.offer');

  @override
  double get offer {
    _$offerAtom.context.enforceReadPolicy(_$offerAtom);
    _$offerAtom.reportObserved();
    return super.offer;
  }

  @override
  set offer(double value) {
    _$offerAtom.context.conditionallyRunInAction(() {
      super.offer = value;
      _$offerAtom.reportChanged();
    }, _$offerAtom, name: '${_$offerAtom.name}_set');
  }

  final _$spreadAtom = Atom(name: '_QuoteState.spread');

  @override
  double get spread {
    _$spreadAtom.context.enforceReadPolicy(_$spreadAtom);
    _$spreadAtom.reportObserved();
    return super.spread;
  }

  @override
  set spread(double value) {
    _$spreadAtom.context.conditionallyRunInAction(() {
      super.spread = value;
      _$spreadAtom.reportChanged();
    }, _$spreadAtom, name: '${_$spreadAtom.name}_set');
  }

  final _$changeAtom = Atom(name: '_QuoteState.change');

  @override
  double get change {
    _$changeAtom.context.enforceReadPolicy(_$changeAtom);
    _$changeAtom.reportObserved();
    return super.change;
  }

  @override
  set change(double value) {
    _$changeAtom.context.conditionallyRunInAction(() {
      super.change = value;
      _$changeAtom.reportChanged();
    }, _$changeAtom, name: '${_$changeAtom.name}_set');
  }

  final _$_QuoteStateActionController = ActionController(name: '_QuoteState');

  @override
  void update(Quote quote) {
    final _$actionInfo = _$_QuoteStateActionController.startAction();
    try {
      return super.update(quote);
    } finally {
      _$_QuoteStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'last: ${last.toString()},bid: ${bid.toString()},offer: ${offer.toString()},spread: ${spread.toString()},change: ${change.toString()}';
    return '{$string}';
  }
}
