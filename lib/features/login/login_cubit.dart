import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/app_repository.dart';
import '../../generated/l10n.dart';
import '../../utils/action_state/action_state.dart';

class LoginCubit extends Cubit<ActionState<void>> {
  LoginCubit(this._appRepository) : super(const ActionState.idle());

  final AppRepository _appRepository;

  Future<void> login(String email, String password) async {
    emit(const ActionState.loading());
    try {
      await _appRepository.login(email, password);
      emit(const ActionState.success());
    } on AuthException catch (e) {
      emit(ActionState.error(message: e.message));
    } catch (e) {
      emit(ActionState.error(message: S.current.error_occurred));
    }
  }
}