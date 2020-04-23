import 'package:get_it/get_it.dart';

import 'connectors/connector.dart';
import 'connectors/iss_connector.dart';
import 'state/quotes_state.dart';
import 'state/securities_state.dart';

setup() {
  final sl = GetIt.I;

  sl.registerSingleton<Connector>(IssConnector());

  sl.registerSingleton<SecuritiesState>(SecuritiesState());
  sl.registerSingleton<QuotesState>(QuotesState());
}