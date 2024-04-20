import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';
import 'package:spacerve/widgets/system_bars_theme.dart';

import '../utils/spacerve_colors.dart';

class DashboardWrapper extends StatelessWidget {
  const DashboardWrapper(
      {super.key,
      required this.body,
      this.lightNavigation = false,
      this.lightStatus = false,
      Color? backgroundColor,
      this.bottomNavBar,
      this.showCircularProgressIndicator = false,
      this.disableTopSafeArea = false})
      : backgroundColor = backgroundColor ?? Colors.black;

  final Widget body;
  final bool lightNavigation;
  final bool lightStatus;
  final Color backgroundColor;
  final Widget? bottomNavBar;
  final bool disableTopSafeArea;
  final bool showCircularProgressIndicator;

  @override
  Widget build(BuildContext context) {
    return SystemBarsTheme(
      lightNavigation: lightNavigation,
      lightStatus: lightStatus,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            top: !disableTopSafeArea,
            child: Stack(children: [
              NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return false;
                },
                child: body,
              ),
              Visibility(
                visible: showCircularProgressIndicator,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  color: Colors.black,
                  child: _progressIndicator,
                ),
              )
            ]),
          ),
          bottomNavigationBar: bottomNavBar,
        ),
      ),
    );
  }

  Widget get _progressIndicator {
    return Center(
      child: Center(
        child: SizedBox(
          width: 40,
          height: 40,
          child: GradientProgressIndicator(
            radius: 20,
            strokeWidth: 6,
            duration: 1,
            gradientStops: const [0.0, 1.0],
            gradientColors: [Colors.black, SpacerveColors.redColor],
            child: const Text(''),
          ),
        ),
      ),
    );
  }
}
