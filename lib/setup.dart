import 'package:get_it/get_it.dart';

import 'connectors/connector.dart';
import 'connectors/iss_connector.dart';
import 'state/securities_state.dart';

setup() {
  final sl = GetIt.I;

  sl.registerSingleton<Connector>(IssConnector());

  sl.registerSingleton<SecuritiesState>(SecuritiesState());
}