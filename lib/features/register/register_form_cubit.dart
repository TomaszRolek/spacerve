import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacerve/utils/validators.dart';

class RegisterFormCubit extends Cubit<bool> {
  RegisterFormCubit() : super(false);

  String email = '';
  String password = '';

  bool notEmpty(String value) => value.isNotEmpty;

  bool emailValidator(String value) => value.isEmailValid;

  bool passwordValidator(String value) => value.isPasswordValid;

  bool get _isValid => emailValidator(email) && passwordValidator(password);

  void setEmail(String email) {
    this.email = email;
    emit(_isValid);
  }

  void setPassword(String password) {
    this.password = password;
    emit(_isValid);
  }

  void clearPassword() {
    password = '';
    emit(false);
  }
}
