import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacerve/features/welcome/welcome_cubit.dart';
import 'package:spacerve/features/welcome/welcome_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WelcomeCubit>(
      create: (context) => WelcomeCubit(),
      child: const WelcomeScreen(),
    );
  }
}
