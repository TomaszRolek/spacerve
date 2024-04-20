import 'dart:ui';

class SpacerveColors {
  static final blackColor = HexColor("#0E0E0E");
  static final redColor = HexColor("#FF0000");
  static final whiteColor = HexColor("#FFFFFF");
  static final greyColor = HexColor("#000000");
  static final backgroundColor = HexColor("#DFDFDF");
  static final frenchSkyBlueColor = HexColor("#81B2F7");
  static final chineseOrangeColor = HexColor("#F66D43");
  static final antiFlashWhiteColor = HexColor("#F2F2F2");
  static final errorBackgroundColor = HexColor("#FFE3E3");
  static final errorTextColor = HexColor("#CC433D");
  static final emeraldColor = HexColor("#4DC073");
  static final azureColor = HexColor("#007AFF");
  static final tealDeerColor = HexColor("#8BF0AC");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
