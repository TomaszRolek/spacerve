import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacerve/features/welcome/welcome_navigator.dart';

import '../../data/app_repository.dart';
import '../../services/router/app_router.dart';
import '../../utils/action_state/action_state.dart';

class DashboardCubit extends Cubit<ActionState<void>> {
  DashboardCubit(this._appRepository) : super(const ActionState.idle());
  final AppRepository _appRepository;

  void signOut(BuildContext context) async {
    _appRepository.signOut().then((_) async {
      context.read<AppRouter>().showWelcomeScreen();
    });
  }

  Future reserve(int capacity, DateTime start, DateTime end) async {
    emit(const ActionState.loading());
    _appRepository.reserve(capacity, start, end).then((value) {
      if (value) {
        emit(const ActionState.success());
      } else {
        emit(const ActionState.error(message: "Brak wolnych sal"));
      }
    });
  }

  void resetState() {
    emit(const ActionState.idle());
  }
}
