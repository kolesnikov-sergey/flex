import 'package:flex/models/position.dart';
import 'package:flex/services/positions_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PositionsCubit extends Cubit<List<Position>> {
  final PositionsService _positionsService;

  PositionsCubit(this._positionsService): super([]) {
    _positionsService.subscribe('').listen((res) => emit(res));
  }
}