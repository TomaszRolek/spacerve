import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/app_repository.dart';
import '../../generated/l10n.dart';
import '../../utils/action_state/action_state.dart';

class RegisterCubit extends Cubit<ActionState<void>> {
  RegisterCubit(this._appRepository) : super(const ActionState.idle());

  final AppRepository _appRepository;

  Future<void> register(String email, String password) async {
    emit(const ActionState.loading());
    try {
      await _appRepository.register(email, password);
      emit(const ActionState.success());
    } catch (e) {
      if ((e as AuthException).statusCode == '400') {
        emit(ActionState.error(message: S.current.register_error));
      } else {
        emit(ActionState.error(message: S.current.error_occurred));
      }
    }
  }
}
