import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacerve/features/register/register_cubit.dart';
import 'package:spacerve/features/register/register_form_cubit.dart';
import 'package:spacerve/features/register/register_screen.dart';
import 'package:spacerve/features/welcome/welcome_navigator.dart';

import '../../../../services/router/app_router.dart';
import '../../utils/action_state/action_state.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(create: (_) => RegisterCubit(context.read())),
        BlocProvider<RegisterFormCubit>(
          create: (_) => RegisterFormCubit(),
        ),
      ],
      child: BlocListener<RegisterCubit, ActionState<void>>(
        listener: (context, registerState) {
          registerState.when(
            idle: () {},
            loading: () {},
            success: (_) => context.read<AppRouter>().showDashboard(),
            error: (message) {
              context.read<RegisterFormCubit>().clearPassword();
            },
          );
        },
        child: const RegisterScreen(),
      ),
    );
  }
}