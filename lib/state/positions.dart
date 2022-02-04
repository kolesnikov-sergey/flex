import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/position.dart';
import '../services/positions_service.dart';

class PositionsCubit extends Cubit<List<Position>> {
  final PositionsService _positionsService;

  PositionsCubit(this._positionsService): super([]) {
    _positionsService.subscribe('').listen((res) => emit(res));
  }
}