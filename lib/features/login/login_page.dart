import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacerve/features/welcome/welcome_navigator.dart';

import '../../../../services/router/app_router.dart';
import '../../utils/action_state/action_state.dart';
import 'login_cubit.dart';
import 'login_form_cubit.dart';
import 'login_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (_) => LoginCubit(context.read()),
        ),
        BlocProvider<LoginFormCubit>(
          create: (_) => LoginFormCubit(),
        ),
      ],
      child: BlocListener<LoginCubit, ActionState<void>>(
        listener: (context, state) {
          state.when(
            idle: () {},
            loading: () {},
            success: (_) => context.read<AppRouter>().showDashboard(),
            error: (message) {
              context.read<LoginFormCubit>().error();
            },
          );
        },
        child: const LoginScreen(),
      ),
    );
  }
}
