import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/security.dart';
import '../../connectors/connector.dart';

class SecuritiesState {
  final List<Security> securities;

  final SecurityType securityType;

  final String? search;

  final bool isLoading;

  final Security? current;

  SecuritiesState({
    this.securities = const [],
    this.securityType = SecurityType.shares,
    this.search,
    this.isLoading = false,
    this.current,
  });

  SecuritiesState copyWith({
    List<Security>? securities,
    SecurityType? securityType,
    String? search,
    bool? isLoading,
    Security? current,
  }) {
    return SecuritiesState(
      securities: securities ?? this.securities,
      securityType: securityType ?? this.securityType,
      search: search ?? this.search,
      isLoading: isLoading ?? this.isLoading,
      current: current ?? this.current,
    );
  }
}

class SecuritiesCubit extends Cubit<SecuritiesState> {
  final Connector _connector;

  SecuritiesCubit(this._connector): super(SecuritiesState());

  Future load([SecurityType? securityType]) async {
    final value = securityType ?? state.securityType;

    emit(state.copyWith(isLoading: true, securityType: value));

    try {
      final securities = await _connector.getSecurities(value);

      emit(state.copyWith(securities: securities, isLoading: false));
    } catch(e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void setSearch(String value) {
    emit(state.copyWith(search: value));
  }

  void setCurrentSecurity(Security security) {
    emit(state.copyWith(current: security));
  }
}