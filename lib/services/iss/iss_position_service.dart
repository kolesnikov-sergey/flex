import 'dart:async';

import '../../models/position.dart';
import '../../services/positions_service.dart';

class IssPositionService extends PositionsService {
  final _positions = [
    Position(id: 'SBER', name: 'Сбербанк', qty: 10),
    Position(id: 'LKOH', name: 'ЛУКОЙЛ', qty: 20),
    Position(id: 'GAZP', name: 'ГАЗПРОМ ао', qty: 5)
  ];

  late StreamController<List<Position>> _positionsController;

  IssPositionService() {
    _positionsController = StreamController<List<Position>>(onListen: _handleListen);
  }

  Stream<List<Position>> subscribe(String account) {
    return _positionsController.stream;
  }

  _handleListen() {
    _positionsController.add(_positions);
  }
}