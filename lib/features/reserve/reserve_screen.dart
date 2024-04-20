import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spacerve/features/reserve/reserve_cubit.dart';
import 'package:spacerve/features/reserve/room_reservation_cubit.dart';
import 'package:spacerve/services/router/app_router.dart';
import 'package:spacerve/utils/extensions/get_extension.dart';
import 'package:spacerve/utils/spacerve_colors.dart';
import 'package:spacerve/utils/spacerve_textstyles.dart';
import '../../generated/l10n.dart';
import '../../services/model/reservation.dart';
import '../../utils/action_state/action_state.dart';
import '../../widgets/dashboard_wrapper.dart';

class ReserveScreen extends StatefulWidget {
  const ReserveScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<ReserveScreen> createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late DateTime startDate;
  late DateTime endDate;
  late DateTime now;

  @override
  void initState() {
    context.read<RoomReservationsCubit>().getRoomReservations(widget.id);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    now = DateTime.now();
    startDate = now;
    endDate = now;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReserveCubit, ActionState>(builder: (context, dashboardState) {
      if (dashboardState is Success) {
        startDate = now;
        endDate = now;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<ReserveCubit>().resetState();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Container(
                  decoration:
                      BoxDecoration(color: SpacerveColors.emeraldColor, borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Center(
                        child: Text("Dokonano rezerwacji", style: SpacerveTextStyles.bold24.copyWith(color: Colors.white))),
                  )),
              margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height / 6, right: 48, left: 48),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
            ),
          );
        });
      } else if (dashboardState is Error) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<ReserveCubit>().resetState();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Container(
                  decoration: BoxDecoration(
                      color: SpacerveColors.redColor.withOpacity(0.5), borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Center(
                        child: Text(
                      "Brak wolnych sal",
                      style: SpacerveTextStyles.bold24.copyWith(color: Colors.white),
                    )),
                  )),
              margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height / 6, right: 48, left: 48),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
            ),
          );
        });
      }
      return DashboardWrapper(
        showCircularProgressIndicator: dashboardState is Loading,
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: OutlinedButton(
                        onPressed: get<AppRouter>().back,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: SpacerveColors.redColor)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            child: Text(
                              "Cofnij się",
                              style: SpacerveTextStyles.bold14.copyWith(color: SpacerveColors.redColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_tabController.index == 0)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Zarezerwuj salę",
                          style: SpacerveTextStyles.bold32.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 50),
                        Text(
                          "Wybierz datę rozpoczęcia",
                          style: SpacerveTextStyles.bold24.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: () => startDatePicker(context),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width - 48,
                            decoration: BoxDecoration(
                                color: startDate != now ? SpacerveColors.redColor : Colors.black,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: SpacerveColors.redColor, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              child: Center(
                                child: Text(
                                  startDate != now ? DateFormat('HH:mm, dd-MM-yyyy').format(startDate) : "Wybierz",
                                  style: SpacerveTextStyles.bold16
                                      .copyWith(color: startDate != now ? Colors.white : SpacerveColors.redColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          "Wybierz datę zakończenia",
                          style: SpacerveTextStyles.bold24.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: () => endDatePicker(context),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width - 48,
                            decoration: BoxDecoration(
                                color: endDate != now ? SpacerveColors.redColor : Colors.black,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: SpacerveColors.redColor, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              child: Center(
                                child: Text(
                                  endDate != now ? DateFormat('HH:mm, dd-MM-yyyy').format(endDate) : "Wybierz",
                                  style: SpacerveTextStyles.bold16
                                      .copyWith(color: endDate != now ? Colors.white : SpacerveColors.redColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        GestureDetector(
                          onTap: () async {
                            if (startDate != now && endDate != now) {
                              await context.read<ReserveCubit>().reserve(widget.id, startDate, endDate);
                              if (context.mounted)
                                await context.read<RoomReservationsCubit>().getRoomReservations(widget.id);
                            }
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width - 48,
                            decoration: BoxDecoration(
                              color: (startDate != now && endDate != now) ? Colors.white : Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              child: Center(
                                child: Text(
                                  "Rezerwuj",
                                  style: SpacerveTextStyles.bold16.copyWith(
                                      color: (startDate != now && endDate != now)
                                          ? SpacerveColors.redColor
                                          : SpacerveColors.redColor.withOpacity(0.3)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (_tabController.index == 1)
                    BlocBuilder<RoomReservationsCubit, List<ReservationModel>?>(builder: (context, reservations) {
                      context.read<RoomReservationsCubit>().getRoomReservations(widget.id);
                      if (reservations != null) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Rezerwacje sali",
                                style: SpacerveTextStyles.bold32.copyWith(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 50),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: reservations.length,
                              itemBuilder: (context, index) {
                                final reservation = reservations[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: SpacerveColors.redColor, width: 2)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Start: ${DateFormat('HH:mm, dd-MM-yyyy').format(reservation.reservation.localStart)}",
                                                  style: SpacerveTextStyles.bold14
                                                      .copyWith(color: SpacerveColors.redColor),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  "Koniec: ${DateFormat('HH:mm, dd-MM-yyyy').format(reservation.reservation.localEnd)}",
                                                  style: SpacerveTextStyles.bold14
                                                      .copyWith(color: SpacerveColors.redColor),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  "Piętro: ${reservation.room.floor}",
                                                  style: SpacerveTextStyles.bold14
                                                      .copyWith(color: SpacerveColors.redColor),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  "Nazwa sali: ${reservation.room.name}",
                                                  style: SpacerveTextStyles.bold14
                                                      .copyWith(color: SpacerveColors.redColor),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  "Ilość osób: ${reservation.room.capacity}",
                                                  style: SpacerveTextStyles.bold14
                                                      .copyWith(color: SpacerveColors.redColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              },
                            ),
                          ],
                        );
                      } else {
                        return const Text("Brak rezerwacji");
                      }
                    }),
                ],
              ),
            ),
          ),
        ]),
        bottomNavBar: Container(
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: SpacerveColors.redColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 24,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TabBar(
            tabs: [
              _tabElement(
                S.current.reserve,
                const Icon(Icons.home_filled),
              ),
              _tabElement(
                S.current.reservations,
                const Icon(Icons.list),
              ),
            ],
            controller: _tabController,
            labelColor: Colors.white,
            labelStyle: SpacerveTextStyles.bold12,
            unselectedLabelColor: Colors.white.withOpacity(0.6),
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.zero,
            indicatorColor: SpacerveColors.redColor,
          ),
        ),
      );
    });
  }

  Widget _tabElement(String? text, Widget? icon) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2,
      child: Tab(
        text: text,
        icon: icon,
        iconMargin: const EdgeInsets.only(bottom: 5),
      ),
    );
  }

  void startDatePicker(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: 190,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                    child: CupertinoDatePicker(
                        minimumDate: DateTime.now(),
                        use24hFormat: true,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          setState(() {
                            startDate = val;
                          });
                        }),
                  ),
                ],
              ),
            ));
  }

  void endDatePicker(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: 190,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                    child: CupertinoDatePicker(
                        initialDateTime: startDate,
                        minimumDate: startDate,
                        use24hFormat: true,
                        onDateTimeChanged: (val) {
                          setState(() {
                            endDate = val;
                          });
                        }),
                  ),
                ],
              ),
            ));
  }
}
