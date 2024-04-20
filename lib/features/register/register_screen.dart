import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacerve/features/register/register_cubit.dart';
import 'package:spacerve/features/register/register_form_cubit.dart';
import 'package:spacerve/utils/extensions/get_extension.dart';
import '../../../../services/router/app_router.dart';
import '../../generated/l10n.dart';
import '../../utils/action_state/action_state.dart';
import '../../utils/spacerve_colors.dart';
import '../../utils/spacerve_textstyles.dart';
import '../../widgets/app_filled_scroll_wrapper.dart';
import '../../widgets/main_button.dart';
import '../../widgets/spacerve_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, ActionState<void>>(
      builder: (context, registerState) {
        return AppFilledScrollWrapper(
            onBackClicked: get<AppRouter>().back,
            showCircularProgressIndicator: registerState is Loading,
            children: [
              Column(children: [
                const SizedBox(height: 48),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(S.current.register, style: SpacerveTextStyles.bold32.copyWith(color: Colors.white)),
                ),
                const SizedBox(height: 16),
                SpacerveTextField(
                    textEditingController: _emailTextController,
                    onChanged: get<RegisterFormCubit>().setEmail,
                    hint: S.current.email,
                    error: S.current.invalid_email,
                    validator: get<RegisterFormCubit>().emailValidator,
                    inputType: TextInputType.emailAddress),
                const SizedBox(height: 16),
                SpacerveTextField(
                    textEditingController: _passwordTextController,
                    onChanged: get<RegisterFormCubit>().setPassword,
                    hint: S.current.password,
                    error: S.current.invalid_pass,
                    validator: get<RegisterFormCubit>().passwordValidator,
                    isPassword: true),
                const SizedBox(height: 20),
                if (registerState is Error)
                  Text(registerState.message,
                      style: SpacerveTextStyles.normal12.copyWith(color: SpacerveColors.redColor)),
                const SizedBox(height: 180),
              ]),
              const Spacer(flex: 100),
              BlocBuilder<RegisterFormCubit, bool>(
                builder: (context, state) {
                  return MainButton(
                    onClicked: () => get<RegisterCubit>().register(
                      _emailTextController.text.trim(),
                      _passwordTextController.text.trim(),
                    ),
                    enabled: state,
                    label: S.current.register,
                    padding: 0,
                  );
                },
              ),
              const SizedBox(height: 32),
            ]);
      },
    );
  }
}
