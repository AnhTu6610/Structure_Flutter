import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/resource/dimen.dart';
import 'package:flutter/material.dart';

typedef OnPressed();

class StandardButton extends StatelessWidget {
  final OnPressed onPressed;
  final Widget child;
  final Color colorBackground;
  final Color colorOutline;
  final Color textColor;
  final String iconAsset;
  final String iconAssetLeft;
  final double width;
  final double height;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry padding;
  StandardButton(
      {Key key,
      @required this.onPressed,
      @required this.child,
      this.colorBackground,
      this.colorOutline,
      this.textColor,
      this.width,
      this.height,
      this.borderRadius,
      this.iconAsset,
      this.elevation,
      this.padding,
      this.iconAssetLeft})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      splashColor: Colors.white38,
      elevation: this.elevation ?? 0,
      highlightElevation: 0.5,
      color: this.colorBackground ?? ColorsData.green_1,
      textColor: this.textColor ?? Colors.white,
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(this.borderRadius != null
            ? this.borderRadius
            : Dimen.borderRadious),
        side: BorderSide(color: this.colorOutline ?? Colors.transparent),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          iconAsset != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    iconAsset,
                    scale: 3,
                  ),
                )
              : Container(),
          child,
        ],
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}
