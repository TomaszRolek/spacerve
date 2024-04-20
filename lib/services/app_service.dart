import 'package:dart_extensions/dart_extensions.dart';
import 'package:spacerve/services/model/reservation.dart';
import 'package:spacerve/services/model/room.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/auth_client.dart';

class AppService {
  final AuthClient _authClient;

  AppService(this._authClient);

  Future<void> register(String email, String password) async {
    await _authClient.signUp(email, password);

    await login(email, password);
    return;
  }

  Future<AuthResponse> login(String email, String password) async {
    return await _authClient.signIn(email, password);
  }

  Future<bool> get isLogged async {
    return await _authClient.isLogged;
  }

  Future<void> signOut() async {
    return await _authClient.signOut();
  }

  Future<RoomsList?> getRooms() async {
    final response = await _authClient.client.from('room').select().order('capacity', ascending: true);
    if (response == null) {
      return null;
    } else {
      return RoomsList.fromMap(response);
    }
  }

  Future<RoomsList?> getSuitableRooms(int capacity) async {
    final response =
        await _authClient.client.from('room').select().gte('capacity', capacity).order('capacity', ascending: true);
    if (response == null) {
      return null;
    } else {
      return RoomsList.fromMap(response);
    }
  }

  Future<void> deleteReservation(int reservationId) async {
    await _authClient.client.from("reservations").delete().match({"id": reservationId});
  }

  Future<void> approveReservation(int reservationId) async {
    await _authClient.client.from("reservations").update({"approved": true}).match({"id": reservationId});
  }

  Future<List<ReservationModel>?> getUserReservations() async {
    final endTime = DateTime.now();
    final startCurrentDayDate = DateTime(endTime.year, endTime.month, endTime.day, 0, 0, 1);
    final response = await _authClient.client
        .from('reservations')
        .select()
        .match({'user_id': _authClient.currentLoggedUserId}).gte("start", startCurrentDayDate);
    if (response == null) {
      return null;
    } else {
      final List<ReservationModel> reservationsModel = [];
      final reservations = ReservationsList.fromMap(response);
      for (int i = 0; i < reservations.items.length; i++) {
        var roomInfo = await _authClient.client
            .from('room')
            .select()
            .match({'id': reservations.items[i].roomId})
            .limit(1)
            .maybeSingle();
        reservationsModel.add(ReservationModel(reservation: reservations.items[i], room: Room.fromMap(roomInfo)));
      }
      return reservationsModel;
    }
  }

  Future<List<ReservationModel>?> getRoomReservations(int id) async {
    final endTime = DateTime.now();
    final startCurrentDayDate = DateTime(endTime.year, endTime.month, endTime.day, 0, 0, 1);
    final response = await _authClient.client
        .from('reservations')
        .select()
        .match({'room_id': id}).gte("start", startCurrentDayDate);
    if (response == null) {
      return null;
    } else {
      final List<ReservationModel> reservationsModel = [];
      final reservations = ReservationsList.fromMap(response);
      for (int i = 0; i < reservations.items.length; i++) {
        var roomInfo = await _authClient.client
            .from('room')
            .select()
            .match({'id': id})
            .limit(1)
            .maybeSingle();
        reservationsModel.add(ReservationModel(reservation: reservations.items[i], room: Room.fromMap(roomInfo)));
      }
      return reservationsModel;
    }
  }

  Future<bool> reserve(int capacity, DateTime start, DateTime end) async {
    final rooms = await getSuitableRooms(capacity);
    if (rooms!.items.isNotEmpty) {
      for (int i = 0; i < rooms.items.length; i++) {
        final response = await _authClient.client
            .from('reservations')
            .select()
            .match({'room_id': rooms.items[i].id})
            .gte('start', start)
            .lt('start', end);
        final response1 = await _authClient.client
            .from('reservations')
            .select()
            .match({'room_id': rooms.items[i].id})
            .gt('end', start)
            .lte('end', end);
        final response2 = await _authClient.client
            .from('reservations')
            .select()
            .match({'room_id': rooms.items[i].id})
            .lte('start', start)
            .gte('end', end);
        final reservations = ReservationsList.fromMap(response);
        final reservations1 = ReservationsList.fromMap(response1);
        final reservations2 = ReservationsList.fromMap(response2);
        if (reservations.items.isEmptyOrNull &&
            reservations1.items.isEmptyOrNull &&
            reservations2.items.isEmptyOrNull) {
          await _authClient.client.from('reservations').insert({
            'start': start.toIso8601String(),
            'end': end.toIso8601String(),
            'user_id': _authClient.currentLoggedUserId,
            'room_id': rooms.items[i].id
          });
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> reserveOneRoom(int id, DateTime start, DateTime end) async {
    final response = await _authClient.client
        .from('reservations')
        .select()
        .match({'room_id': id})
        .gte('start', start)
        .lt('start', end);
    final response1 =
        await _authClient.client.from('reservations').select().match({'room_id': id}).gt('end', start).lte('end', end);
    final response2 = await _authClient.client
        .from('reservations')
        .select()
        .match({'room_id': id})
        .lte('start', start)
        .gte('end', end);
    final reservations = ReservationsList.fromMap(response);
    final reservations1 = ReservationsList.fromMap(response1);
    final reservations2 = ReservationsList.fromMap(response2);
    if (reservations.items.isEmptyOrNull && reservations1.items.isEmptyOrNull && reservations2.items.isEmptyOrNull) {
      await _authClient.client.from('reservations').insert({
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
        'user_id': _authClient.currentLoggedUserId,
        'room_id': id
      });
      return true;
    }
    return false;
  }
}
