import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spacerve/features/welcome/welcome_cubit.dart';
import 'package:spacerve/features/welcome/welcome_navigator.dart';
import 'package:spacerve/utils/extensions/get_extension.dart';
import 'package:spacerve/utils/spacerve_assets.dart';
import 'package:spacerve/utils/spacerve_colors.dart';
import 'package:spacerve/utils/spacerve_textstyles.dart';
import 'package:spacerve/widgets/main_button.dart';

import '../../generated/l10n.dart';
import '../../services/router/app_router.dart';
import '../../widgets/prevent_app_close_wrapper.dart';
import '../../widgets/system_bars_theme.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
    context.read<WelcomeCubit>().redirect().then((redirect) => redirect ? get<AppRouter>().showDashboard() : null);
  }

  @override
  Widget build(BuildContext context) {
    return PreventAppCloseWrapper(
      child: SystemBarsTheme(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(left: false, right: false, child: _widgetsInColumn(context)),
        ),
      ),
    );
  }

  Widget _widgetsInColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 120),
        Center(child: SvgPicture.asset(SpacerveAssets.appIcon, width: MediaQuery.sizeOf(context).width - 150,)),
        const SizedBox(height: 20),
        Text(S.current.welcome_desc, style: SpacerveTextStyles.normal14.copyWith(color: Colors.white)),
        const Spacer(flex: 90),
        MainButton(onClicked: get<AppRouter>().showLoginScreen, backgroundColor: SpacerveColors.redColor, label: S.current.login,),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: S.current.do_not_have_account, style: SpacerveTextStyles.normal14.copyWith(color: Colors.white)),
              TextSpan(
                text: S.current.register,
                style: SpacerveTextStyles.bold14.copyWith(color: SpacerveColors.redColor),
                recognizer: TapGestureRecognizer()..onTap = get<AppRouter>().showRegisterScreen,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
