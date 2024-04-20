import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacerve/utils/extensions/get_extension.dart';
import 'package:spacerve/utils/spacerve_colors.dart';
import 'package:spacerve/utils/spacerve_textstyles.dart';
import 'package:spacerve/widgets/main_button.dart';
import '../../generated/l10n.dart';
import '../../services/router/app_router.dart';
import '../../utils/action_state/action_state.dart';
import '../../widgets/app_filled_scroll_wrapper.dart';
import '../../widgets/spacerve_text_field.dart';
import 'login_cubit.dart';
import 'login_form_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, ActionState<void>>(builder: (context, loginState) {
      return AppFilledScrollWrapper(
          onBackClicked: get<AppRouter>().back,
          showCircularProgressIndicator: loginState is Loading,
          children: [
            Column(children: [
              const SizedBox(height: 48),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(S.current.login, style: SpacerveTextStyles.bold32.copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 32),
              SpacerveTextField(
                  textEditingController: _emailTextController,
                  onChanged: get<LoginFormCubit>().setEmail,
                  hint: S.current.email,
                  error: S.current.invalid_email,
                  validator: get<LoginFormCubit>().emailValidator,
                  inputType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              SpacerveTextField(
                  textEditingController: _passwordTextController,
                  onChanged: get<LoginFormCubit>().setPassword,
                  hint: S.current.password,
                  error: S.current.invalid_pass,
                  validator: get<LoginFormCubit>().passwordValidator,
                  isPassword: true),
              const SizedBox(height: 20),
              if (loginState is Error)
                Text(S.current.login_error,
                    style: SpacerveTextStyles.normal12.copyWith(color: SpacerveColors.redColor)),
              const SizedBox(height: 180),
            ]),
            const Spacer(flex: 100),
            BlocBuilder<LoginFormCubit, bool>(
              builder: (context, state) {
                return MainButton(
                  onClicked: () => get<LoginCubit>().login(
                    _emailTextController.text.trim(),
                    _passwordTextController.text.trim(),
                  ),
                  enabled: state,
                  label: S.current.login,
                  padding: 0,
                );
              },
            ),
            const SizedBox(height: 32),
          ]);
    });
  }
}
