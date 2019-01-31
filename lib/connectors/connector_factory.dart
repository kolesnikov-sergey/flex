import 'connector.dart';
import 'iss_connector.dart';

class ConnectorFactory {
  static final Connector _connector = IssConnector();

  static Connector getConnector() {
    return _connector;
  }

  ConnectorFactory._internal();
}