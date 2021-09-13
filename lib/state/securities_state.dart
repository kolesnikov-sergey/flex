import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../connectors/connector.dart';
import '../models/security.dart';

part 'securities_state.g.dart';

class SecuritiesState = SecuritiesStateBase with _$SecuritiesState;

abstract class SecuritiesStateBase with Store {
  final _connector = GetIt.I<Connector>();

  @observable
  List<Security> securities = [];

  @observable
  SecurityType securityType = SecurityType.shares;

  @observable
  String? search;

  @observable
  bool isLoading = false;

  @observable
  Security? current;

  @computed
  List<Security> get filteredSecurities {
    final search = this.search;
    if (search == null || search.isEmpty) {
      return securities;
    }
  
    return securities
      .where((item) => item.name.toLowerCase().contains(search.toLowerCase())
        || item.id.toLowerCase().contains(search.toLowerCase())
      )
      .toList();
  }

  @action
  Future<void> loadSecurities(SecurityType type) async {
    if (type == securityType && securities.isNotEmpty) {
      return;
    }

    isLoading = true;
    securityType = type;

    try {
      securities = await _connector.getSecurities(type);
    } finally {
      isLoading = false;
    }
  }

  @action
  void setSearch(String value) {
    search = value;
  }

  @action 
  void setCurrent(Security security) {
    current = security;
  }
}