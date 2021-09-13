// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'securities_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SecuritiesState on SecuritiesStateBase, Store {
  Computed<List<Security>>? _$filteredSecuritiesComputed;

  @override
  List<Security> get filteredSecurities => (_$filteredSecuritiesComputed ??=
          Computed<List<Security>>(() => super.filteredSecurities))
      .value;

  final _$securitiesAtom = Atom(name: 'SecuritiesStateBase.securities');

  @override
  List<Security> get securities {
    _$securitiesAtom.context.enforceReadPolicy(_$securitiesAtom);
    _$securitiesAtom.reportObserved();
    return super.securities;
  }

  @override
  set securities(List<Security> value) {
    _$securitiesAtom.context.conditionallyRunInAction(() {
      super.securities = value;
      _$securitiesAtom.reportChanged();
    }, _$securitiesAtom, name: '${_$securitiesAtom.name}_set');
  }

  final _$securityTypeAtom = Atom(name: 'SecuritiesStateBase.securityType');

  @override
  SecurityType get securityType {
    _$securityTypeAtom.context.enforceReadPolicy(_$securityTypeAtom);
    _$securityTypeAtom.reportObserved();
    return super.securityType;
  }

  @override
  set securityType(SecurityType value) {
    _$securityTypeAtom.context.conditionallyRunInAction(() {
      super.securityType = value;
      _$securityTypeAtom.reportChanged();
    }, _$securityTypeAtom, name: '${_$securityTypeAtom.name}_set');
  }

  final _$searchAtom = Atom(name: 'SecuritiesStateBase.search');

  @override
  String? get search {
    _$searchAtom.context.enforceReadPolicy(_$searchAtom);
    _$searchAtom.reportObserved();
    return super.search;
  }

  @override
  set search(String? value) {
    _$searchAtom.context.conditionallyRunInAction(() {
      super.search = value;
      _$searchAtom.reportChanged();
    }, _$searchAtom, name: '${_$searchAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: 'SecuritiesStateBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$currentAtom = Atom(name: 'SecuritiesStateBase.current');

  @override
  Security? get current {
    _$currentAtom.context.enforceReadPolicy(_$currentAtom);
    _$currentAtom.reportObserved();
    return super.current;
  }

  @override
  set current(Security? value) {
    _$currentAtom.context.conditionallyRunInAction(() {
      super.current = value;
      _$currentAtom.reportChanged();
    }, _$currentAtom, name: '${_$currentAtom.name}_set');
  }

  final _$loadSecuritiesAsyncAction = AsyncAction('loadSecurities');

  @override
  Future<void> loadSecurities(SecurityType type) {
    return _$loadSecuritiesAsyncAction.run(() => super.loadSecurities(type));
  }

  final _$SecuritiesStateBaseActionController =
      ActionController(name: 'SecuritiesStateBase');

  @override
  void setSearch(String value) {
    final _$actionInfo = _$SecuritiesStateBaseActionController.startAction();
    try {
      return super.setSearch(value);
    } finally {
      _$SecuritiesStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrent(Security security) {
    final _$actionInfo = _$SecuritiesStateBaseActionController.startAction();
    try {
      return super.setCurrent(security);
    } finally {
      _$SecuritiesStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'securities: ${securities.toString()},securityType: ${securityType.toString()},search: ${search.toString()},isLoading: ${isLoading.toString()},current: ${current.toString()},filteredSecurities: ${filteredSecurities.toString()}';
    return '{$string}';
  }
}
