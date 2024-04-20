import 'package:spacerve/services/model/room.dart';

class ReservationsList {
  ReservationsList({required this.items});

  factory ReservationsList.fromMap(List<dynamic> reservations) {
    return ReservationsList(items: reservations.map((e) => Reservation.fromMap(e as Map)).toList());
  }

  List<Reservation> items = [];
}

class Reservation {
  final int id;
  final int roomId;
  final DateTime localStart;
  final DateTime localEnd;
  final bool approved;
  final String userId;

  Reservation({
    required this.id,
    required this.localEnd,
    required this.localStart,
    required this.approved,
    required this.roomId,
    required this.userId
  });

  Reservation.fromMap(Map<dynamic, dynamic> map)
      : id = map['id'],
        localEnd = DateTime.parse(map['end']).toLocal(),
        approved = map['approved'] as bool,
        roomId = map['room_id'],
        userId = map['user_id'] as String,
        localStart = DateTime.parse(map['start']).toLocal();
}

class ReservationModel {
  ReservationModel({required this.reservation, required this.room});

  Reservation reservation;
  Room room;
}