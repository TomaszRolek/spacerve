import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:spacerve/utils/spacerve_colors.dart';
import 'package:spacerve/widgets/system_bars_theme.dart';

const defPaddingHorizontal = 24.0;
const defTopAppViewHeight = 16.0;

class AppFilledScrollWrapper extends StatelessWidget {
  final List<Widget> children;
  final bool lightNavigation;
  final bool lightStatus;
  final Color backgroundColor;
  final VoidCallback? onBackClicked;
  final double paddingHorizontal;
  final double topMargin;
  final bool showCircularProgressIndicator;
  final CrossAxisAlignment crossAxisAlignment;

  const AppFilledScrollWrapper(
      {required this.children,
      this.lightNavigation = false,
      this.lightStatus = false,
      this.onBackClicked,
      this.paddingHorizontal = defPaddingHorizontal,
      this.topMargin = defTopAppViewHeight,
      this.showCircularProgressIndicator = false,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      Color? backgroundColor,
      Key? key})
      : backgroundColor = backgroundColor ?? Colors.black,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SystemBarsTheme(
      lightNavigation: lightNavigation,
      lightStatus: lightStatus,
      child: Material(
        child: GestureDetector(
          onTap: FocusManager.instance.primaryFocus?.unfocus,
          child: Scaffold(
            body: Container(
              decoration: _backgroundColor,
              child: SafeArea(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowIndicator();
                          return false;
                        },
                        child: CustomScrollView(
                          slivers: [
                            SliverFillRemaining(
                                hasScrollBody: false,
                                child: Column(
                                  crossAxisAlignment: crossAxisAlignment,
                                  children: [
                                    SizedBox(height: topMargin),
                                    if (onBackClicked != null)
                                      GestureDetector(
                                        onTap: onBackClicked,
                                        child: const Icon(Icons.arrow_back, color: Colors.white),
                                      ),
                                    ...children
                                  ],
                                ))
                          ],
                        ),
                      ),
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
                  ],
                ),
              ),
            ),
          ),
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

  BoxDecoration get _backgroundColor {
    if (showCircularProgressIndicator) {
      return const BoxDecoration(color: Colors.black);
    } else {
      return withoutGradient;
    }
  }

  BoxDecoration get withoutGradient {
    return BoxDecoration(color: backgroundColor);
  }
}
