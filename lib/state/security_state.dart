import 'package:flutter/foundation.dart';

import '../models/security.dart';

class SecurityState with ChangeNotifier {
  Security _security;
  SecurityType _securityType;

  Security getSecurity() => _security;
  SecurityType getSecurityType() => _securityType;
  setSecurity(Security security, SecurityType type) {
    _security = security;
    _securityType = type;

    notifyListeners();
  }
}