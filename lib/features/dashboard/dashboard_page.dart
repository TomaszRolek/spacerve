import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacerve/features/dashboard/qr_cubit.dart';
import 'package:spacerve/features/dashboard/reservations_cubit.dart';
import 'package:spacerve/features/dashboard/rooms_cubit.dart';

import 'dashboard_cubit.dart';
import 'dashboard_screen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DashboardCubit(context.read()),
        ),
        BlocProvider(
          create: (context) => ReservationsCubit(context.read()),
        ),
        BlocProvider(
          create: (context) => QrCubit(context.read()),
        ),
        BlocProvider(
          create: (context) => RoomsCubit(context.read()),
        ),
      ],
      child: const DashboardScreen(),
    );
  }
}
