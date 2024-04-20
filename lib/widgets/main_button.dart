import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spacerve/utils/spacerve_assets.dart';
import 'package:spacerve/utils/spacerve_textstyles.dart';

const defHeight = 56.0;
const defPadding = 24.0;

class MainButton extends StatelessWidget {
  final Function()? onClicked;
  final double height;
  final Color backgroundColor;
  final Widget image;
  final bool enabled;
  final String label;
  final double padding;

  MainButton(
      {Key? key,
      this.onClicked,
      this.height = defHeight,
      this.padding = defPadding,
      this.enabled = true,
      Color? backgroundColor,
      Widget? image,
      required this.label})
      : backgroundColor = backgroundColor ?? Colors.red,
        image = image ??
            SvgPicture.asset(
              SpacerveAssets.icArrowForward,
              color: Colors.white,
            ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: SizedBox(
        height: height,
        width: MediaQuery.sizeOf(context).width,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            splashFactory: NoSplash.splashFactory,
          ),
          onPressed: enabled ? onClicked : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: SpacerveTextStyles.bold16.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                image
              ],
            ),
          ),
        ),
      ),
    );
  }
}
