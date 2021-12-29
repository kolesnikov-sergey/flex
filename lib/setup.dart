import 'package:get_it/get_it.dart';

import 'connectors/connector.dart';
import 'connectors/iss_connector.dart';

setup() {
  final sl = GetIt.I;

  sl.registerSingleton<Connector>(IssConnector());
}