import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../connectors/connector.dart';
import '../models/security.dart';

class SecuritiesState with ChangeNotifier {
  final _connector = GetIt.I<Connector>();

  List<Security> _securities = [];
  List<Security> _filteredSecurities = [];
  SecurityType _securityType = SecurityType.shares;
  String _search;
  bool _isLoading = false;

  SecuritiesState();

  SecurityType getSecurityType() => _securityType;

  String getSearch() => _search;
  setSearch(String search) {
    _search = search;
    _filterSecurities();
    notifyListeners();
  }

  List<Security> getSecurities() => _filteredSecurities;

  Future<void> loadSecurities(SecurityType type) async {
    _isLoading = true;
    _securityType = type;
    _filteredSecurities = [];
    notifyListeners();
    try {
      _securities = await _connector.getSecurities(type);
      _filterSecurities();
    } finally {
      _isLoading = false;
    }
  
    notifyListeners();
  }

  bool getIsLoading() => _isLoading;

  _filterSecurities() {
    if (_search == null || _search.isEmpty) {
      _filteredSecurities = _securities;
      return;
    }
  
    _filteredSecurities = _securities
      .where((item) => item.name.toLowerCase().contains(_search?.toLowerCase())
        || item.id.toLowerCase().contains(_search?.toLowerCase())
      )
      .toList();
  }
}