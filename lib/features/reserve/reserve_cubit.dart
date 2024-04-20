import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/app_repository.dart';
import '../../utils/action_state/action_state.dart';

class ReserveCubit extends Cubit<ActionState<void>> {
  ReserveCubit(this._appRepository) : super(const ActionState.idle());
  final AppRepository _appRepository;

  Future reserve(int id, DateTime start, DateTime end) async {
    emit(const ActionState.loading());
    _appRepository.reserveOneRoom(id, start, end).then((value) {
      if (value) {
        emit(const ActionState.success());
      } else {
        emit(const ActionState.error(message: "Brak wolnego terminu"));
      }
    });
  }

  void resetState() {
    emit(const ActionState.idle());
  }
}
