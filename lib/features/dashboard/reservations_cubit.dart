import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacerve/services/model/reservation.dart';

import '../../data/app_repository.dart';

class ReservationsCubit extends Cubit<List<ReservationModel>?> {
  ReservationsCubit(this._appRepository) : super(null);
  final AppRepository _appRepository;

  Future<void> getUserReservations() async {
    final reservations = await _appRepository.getUserReservations();
    if (reservations != null) emit(reservations);
  }

  Future<void> getRoomReservations(int id) async {
    final reservations = await _appRepository.getRoomReservations(id);
    if (reservations != null) emit(reservations);
  }

  Future<void> deleteReservation(int reservationId) async {
    await _appRepository.deleteReservation(reservationId);
  }
}
