import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacerve/services/model/reservation.dart';

import '../../data/app_repository.dart';

class RoomReservationsCubit extends Cubit<List<ReservationModel>?> {
  RoomReservationsCubit(this._appRepository) : super(null);
  final AppRepository _appRepository;

  Future<void> getRoomReservations(int id) async {
    final reservations = await _appRepository.getRoomReservations(id);
    if (reservations != null) emit(reservations);
  }
}
