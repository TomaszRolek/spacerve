import 'package:flutter/cupertino.dart';

import 'spacerve_colors.dart';


class SpacerveTextStyles {
  static final TextStyle common = TextStyle(color: SpacerveColors.blackColor);
  static final TextStyle normal12 = common.copyWith(fontSize: 12, fontWeight: FontWeight.w400);
  static final TextStyle normal14 = common.copyWith(fontSize: 14, fontWeight: FontWeight.w400);
  static final TextStyle normal16 = common.copyWith(fontSize: 16, fontWeight: FontWeight.w400);
  static final TextStyle bold12 = common.copyWith(fontSize: 12, fontWeight: FontWeight.w700);
  static final TextStyle bold14 = common.copyWith(fontSize: 14, fontWeight: FontWeight.w700);
  static final TextStyle bold16 = common.copyWith(fontSize: 16, fontWeight: FontWeight.w700);
  static final TextStyle bold32 = common.copyWith(fontSize: 32, fontWeight: FontWeight.w900);
  static final TextStyle bold24 = common.copyWith(fontSize: 24, fontWeight: FontWeight.w900);
}
