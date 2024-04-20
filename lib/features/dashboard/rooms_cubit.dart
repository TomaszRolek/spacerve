import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacerve/services/model/room.dart';

import '../../data/app_repository.dart';

class RoomsCubit extends Cubit<RoomsList?> {
  RoomsCubit(this._appRepository) : super(null);
  final AppRepository _appRepository;

  Future<void> getRooms() async {
    final rooms = await _appRepository.getRooms();
    if (rooms != null) emit(rooms);
  }
}
