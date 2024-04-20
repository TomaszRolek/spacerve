import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spacerve/utils/spacerve_assets.dart';

const defHeight = 56.0;
const defWidth = 56.0;
const defPaddingLeft = 0.0;
const defPaddingRight = 24.0;

class NextButton extends StatelessWidget {
  final Function()? onClicked;
  final double height;
  final double width;
  final double paddingRight;
  final double paddingLeft;
  final Color backgroundColor;
  final Widget image;
  final bool enabled;

  NextButton(
      {Key? key,
      this.onClicked,
      this.height = defHeight,
      this.width = defWidth,
      this.paddingLeft = defPaddingLeft,
      this.paddingRight = defPaddingRight,
      this.enabled = true,
      Color? backgroundColor,
      Widget? image})
      : backgroundColor = backgroundColor ?? Colors.red,
        image = image ?? SvgPicture.asset(SpacerveAssets.icArrowForward, color: Colors.white,),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: paddingLeft, right: paddingRight),
      child: SizedBox(
          height: height,
          width: width,
          child: FloatingActionButton(
              onPressed: enabled ? onClicked : null,
              backgroundColor: enabled ? backgroundColor : Colors.grey.withOpacity(0.2),
              heroTag: null,
              elevation: 0,
              highlightElevation: 0,
              child: image)),
    );
  }
}
