import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spacerve/features/dashboard/dashboard_cubit.dart';
import 'package:spacerve/features/dashboard/dashboard_navigator.dart';
import 'package:spacerve/features/dashboard/qr_cubit.dart';
import 'package:spacerve/features/dashboard/reservations_cubit.dart';
import 'package:spacerve/features/dashboard/rooms_cubit.dart';
import 'package:spacerve/services/model/room.dart';
import 'package:spacerve/utils/extensions/get_extension.dart';
import 'package:spacerve/utils/spacerve_colors.dart';
import 'package:spacerve/utils/spacerve_textstyles.dart';
import '../../generated/l10n.dart';
import '../../services/model/reservation.dart';
import '../../services/router/app_router.dart';
import '../../utils/action_state/action_state.dart';
import '../../widgets/dashboard_wrapper.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late DateTime startDate;
  late DateTime endDate;
  late DateTime now;
  late int numberOfPeople;
  late final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController _controller;

  @override
  void initState() {
    now = DateTime.now();
    startDate = now;
    endDate = now;
    numberOfPeople = 0;
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    context.read<ReservationsCubit>().getUserReservations();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrCubit, ActionState>(builder: (context, state) {
      return BlocBuilder<DashboardCubit, ActionState>(builder: (context, dashboardState) {
        if (dashboardState is Success) {
          startDate = now;
          endDate = now;
          numberOfPeople = 0;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<DashboardCubit>().resetState();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Container(
                    decoration:
                        BoxDecoration(color: SpacerveColors.emeraldColor, borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Center(
                          child: Text(
                        "Dokonano rezerwacji",
                        style: SpacerveTextStyles.bold24.copyWith(color: Colors.white),
                      )),
                    )),
                margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height / 6, right: 48, left: 48),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
              ),
            );
          });
        } else if (dashboardState is Error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<DashboardCubit>().resetState();
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
        } else if (state is Error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<QrCubit>().resetState();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Container(
                    decoration: BoxDecoration(
                        color: SpacerveColors.redColor.withOpacity(0.5), borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Center(
                          child: Text(
                        "Brak rezerwacji danej sali o danej godzinie",
                        style: SpacerveTextStyles.bold24.copyWith(color: Colors.white),
                      )),
                    )),
                margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height / 6, right: 48, left: 48),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
              ),
            );
            _controller.resumeCamera();
          });
        } else if (state is Success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<QrCubit>().resetState();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Container(
                    decoration:
                        BoxDecoration(color: SpacerveColors.emeraldColor, borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Center(
                          child: Text(
                        "Potwierdzono rezerwację",
                        style: SpacerveTextStyles.bold24.copyWith(color: Colors.white),
                      )),
                    )),
                margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height / 6, right: 48, left: 48),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
              ),
            );
            _controller.resumeCamera();
          });
        }
        return DashboardWrapper(
          showCircularProgressIndicator: dashboardState is Loading || state is Loading,
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
                          onPressed: () => context.read<DashboardCubit>().signOut(context),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: SpacerveColors.redColor)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              child: Text(
                                S.current.logout,
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
                          Text(
                            "Wybierz liczbę osób",
                            style: SpacerveTextStyles.bold24.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton(
                            onPressed: () => choseNumberOfPeople(context),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width - 48,
                              decoration: BoxDecoration(
                                  color: numberOfPeople != 0 ? SpacerveColors.redColor : Colors.black,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: SpacerveColors.redColor, width: 2)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                child: Center(
                                  child: Text(
                                    numberOfPeople.toString(),
                                    style: SpacerveTextStyles.bold16
                                        .copyWith(color: numberOfPeople != 0 ? Colors.white : SpacerveColors.redColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: () async {
                              if (numberOfPeople != 0 && startDate != now && endDate != now) {
                                await context.read<DashboardCubit>().reserve(numberOfPeople, startDate, endDate);
                                if (context.mounted) await context.read<ReservationsCubit>().getUserReservations();
                              }
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width - 48,
                              decoration: BoxDecoration(
                                color: (numberOfPeople != 0 && startDate != now && endDate != now)
                                    ? Colors.white
                                    : Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                child: Center(
                                  child: Text(
                                    "Rezerwuj",
                                    style: SpacerveTextStyles.bold16.copyWith(
                                        color: (numberOfPeople != 0 && startDate != now && endDate != now)
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
                      BlocBuilder<RoomsCubit, RoomsList?>(builder: (context, rooms) {
                        context.read<RoomsCubit>().getRooms();
                        if (rooms != null) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  S.current.free_rooms,
                                  style: SpacerveTextStyles.bold32.copyWith(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 50),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: rooms.items.length,
                                itemBuilder: (context, index) {
                                  final room = rooms.items[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: GestureDetector(
                                      onTap: () => get<AppRouter>().reserve(room.id),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(color: SpacerveColors.redColor, width: 2)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Piętro: ${room.floor}",
                                                  style:
                                                      SpacerveTextStyles.bold14.copyWith(color: SpacerveColors.redColor),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  "Nazwa sali: ${room.name}",
                                                  style:
                                                      SpacerveTextStyles.bold14.copyWith(color: SpacerveColors.redColor),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  "Ilość osób: ${room.capacity}",
                                                  style:
                                                      SpacerveTextStyles.bold14.copyWith(color: SpacerveColors.redColor),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return const Text("Brak sal");
                        }
                      }),
                    if (_tabController.index == 2)
                      BlocBuilder<ReservationsCubit, List<ReservationModel>?>(builder: (context, reservations) {
                        context.read<ReservationsCubit>().getUserReservations();
                        if (reservations != null) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Twoje rezerwacje",
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
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      await context
                                                          .read<ReservationsCubit>()
                                                          .deleteReservation(reservation.reservation.id);
                                                      setState(() async {
                                                        await context.read<ReservationsCubit>().getUserReservations();
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
                                                          border: Border.all(color: SpacerveColors.redColor, width: 2)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                        child: Text(
                                                          "Zrezygnuj",
                                                          style: SpacerveTextStyles.bold14
                                                              .copyWith(color: SpacerveColors.redColor),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        border: Border.all(color: SpacerveColors.redColor, width: 2)),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                      child: Text(
                                                        "Potwierdź \nrezerwację",
                                                        style: SpacerveTextStyles.bold14
                                                            .copyWith(color: SpacerveColors.redColor),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
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
                    if (_tabController.index == 3)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Zeskanuj kod w celu potwierdzenia rezerwacji",
                            style: SpacerveTextStyles.bold32.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 50),
                          Text(
                            "Możesz zeskanować kod w czasie od 15 minut do rozpoczęcia rezerwacji do 15 minut po rozpoczęciu. Jeżeli w tym czasie nie potwierdzisz rezerwacji, rezerwacja jest nieważna.",
                            style: SpacerveTextStyles.bold16.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                              height: 300,
                              width: 300,
                              child: QRView(
                                key: _qrKey,
                                onQRViewCreated: (controller) {
                                  _controller = controller;
                                  controller.scannedDataStream.listen((scanData) async {
                                    if (scanData.code != null) {
                                      controller.stopCamera();
                                      await context.read<QrCubit>().approveReservation(int.parse(scanData.code!));
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
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
                  S.current.rooms,
                  const Icon(Icons.list),
                ),
                _tabElement(
                  S.current.your_reservations,
                  const Icon(Icons.calendar_month_rounded),
                ),
                _tabElement(
                  S.current.scan,
                  const Icon(Icons.camera_alt),
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
    });
  }

  Widget _tabElement(String? text, Widget? icon) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 4,
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

  void choseNumberOfPeople(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: 190,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                    child: CupertinoPicker(
                        itemExtent: 32,
                        onSelectedItemChanged: (val) {
                          setState(() {
                            numberOfPeople = val;
                          });
                        },
                        children: List<Widget>.generate(_numbers.length, (int index) {
                          return Center(child: Text(_numbers[index].toString()));
                        })),
                  ),
                ],
              ),
            ));
  }

  static const List<int> _numbers = <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
}
