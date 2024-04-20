class RoomsList {
  RoomsList({required this.items});

  factory RoomsList.fromMap(List<dynamic> rooms) {
    return RoomsList(items: rooms.map((e) => Room.fromMap(e as Map)).toList());
  }

  List<Room> items = [];
}

class Room {
  final int id;
  final int floor;
  final int capacity;
  final String name;

  Room({
    required this.id,
    required this.floor,
    required this.capacity,
    required this.name
  });

  Room.fromMap(Map<dynamic, dynamic> map)
      : id = map['id'],
        floor = map['floor'],
        name = map['name'] as String,
        capacity = map['capacity'];
}
