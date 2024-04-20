import 'package:spacerve/services/model/reservation.dart';
import 'package:spacerve/services/model/room.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../services/app_service.dart';

class AppRepository {
  final AppService _service;

  AppRepository(this._service);

  Future<void> register(String email, String password) async {
    return await _service.register(email, password);
  }

  Future<AuthResponse> login(String email, String password) async {
    return await _service.login(email, password);
  }

  Future<bool> get isLogged async {
    return await _service.isLogged;
  }

  Future<void> signOut() async {
    return await _service.signOut();
  }

  Future<bool> reserve(int capacity, DateTime start, DateTime end) async {
    return await _service.reserve(capacity, start, end);
  }

  Future<bool> reserveOneRoom(int id, DateTime start, DateTime end) async {
    return await _service.reserveOneRoom(id, start, end);
  }

  Future<List<ReservationModel>?> getUserReservations() async {
    return await _service.getUserReservations();
  }

  Future<List<ReservationModel>?> getRoomReservations(int id) async {
    return await _service.getRoomReservations(id);
  }

  Future<void> deleteReservation(int reservationId) async {
    await _service.deleteReservation(reservationId);
  }

  Future<void> approveReservation(int reservationId) async {
    await _service.approveReservation(reservationId);
  }

  Future<RoomsList?> getRooms() async {
    return await _service.getRooms();
  }
}
