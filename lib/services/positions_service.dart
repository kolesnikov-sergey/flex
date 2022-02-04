import '../models/position.dart';

abstract class PositionsService {
  Stream<List<Position>> subscribe(String account);
}