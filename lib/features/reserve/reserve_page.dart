import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacerve/features/reserve/reserve_cubit.dart';
import 'package:spacerve/features/reserve/reserve_screen.dart';
import 'package:spacerve/features/reserve/room_reservation_cubit.dart';


class ReservePage extends StatelessWidget {
  final int id;
  const ReservePage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReserveCubit(context.read()),
        ),
        BlocProvider(
          create: (context) => RoomReservationsCubit(context.read()),
        ),
      ],
      child: ReserveScreen(id: id),
    );
  }
}
