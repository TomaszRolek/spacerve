import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacerve/utils/action_state/action_state.dart';

import '../../data/app_repository.dart';

class QrCubit extends Cubit<ActionState> {
  QrCubit(this._appRepository) : super(const ActionState.idle());
  final AppRepository _appRepository;

  Future<void> approveReservation(int roomId) async {
    bool wasReservationApproved = false;
    emit(const ActionState.loading());
    _appRepository.getUserReservations().then((reservations) async {
      if (reservations != null) {
        for (int i = 0; i < reservations.length; i++) {
          if (reservations[i].room.id == roomId &&
              DateTime.now().difference(reservations[i].reservation.localStart).abs() <= const Duration(minutes: 15)) {
            await _appRepository.approveReservation(reservations[i].reservation.id);
            emit(const ActionState.success());
            wasReservationApproved = true;
          }
        }
        if (!wasReservationApproved) emit(const ActionState.error(message: "Brak rezerwacji na daną godzinę"));
      }
    });
  }

  void resetState() {
    emit(const ActionState.idle());
  }
}
