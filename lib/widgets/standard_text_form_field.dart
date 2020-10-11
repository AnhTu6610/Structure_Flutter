import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/resource/dimen.dart';
import 'package:flutter/material.dart';

enum StandardTextFormFieldStatus { init, valid, unvalid }

class StandardTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final Color hintColors;
  final int maxLines;
  final TextInputAction textInputAction;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final Function onTap;
  final bool readOnly;
  final bool filled;
  final Color fillColor;
  final bool enabledBorder;
  final Widget suffixIcon;
  final String labelText;
  final double borderRadius;
  final TextInputType keyboardType;
  final EdgeInsetsGeometry contentPadding;
  StandardTextFormField(
      {Key key,
      this.controller,
      this.hint,
      this.hintColors,
      this.maxLines = 1,
      this.textInputAction = TextInputAction.done,
      this.validator,
      this.onFieldSubmitted,
      this.onTap,
      this.readOnly = false,
      this.filled = false,
      this.fillColor,
      this.enabledBorder = false,
      this.suffixIcon,
      this.labelText,
      this.borderRadius,
      this.keyboardType,
      this.contentPadding})
      : super(key: key);

  @override
  _StandardTextFormFieldState createState() => _StandardTextFormFieldState();
}

class _StandardTextFormFieldState extends State<StandardTextFormField> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      _controller = widget.controller;
    } else {
      _controller = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: widget.filled,
        fillColor: widget.fillColor,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        // labelStyle: TextStyle(
        //   color: ColorsData.lightGray,
        //   fontSize: FontsSize.smaller,
        // ),
        hintText: widget.hint,
        // hintStyle: TextStyle(
        //   color: widget.hintColors ?? ColorsData.lightGray,
        //   fontSize: FontsSize.smaller,
        // ),
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        enabledBorder: widget.enabledBorder == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? Dimen.borderInput),
                borderSide: BorderSide(color: ColorsData.blue_1, width: 1.0))
            : null,
        border: widget.enabledBorder == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? Dimen.borderInput),
                borderSide: BorderSide(color: ColorsData.blue_1, width: 1.0))
            : null,
        focusedBorder: widget.enabledBorder == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? Dimen.borderInput),
                borderSide: BorderSide(color: ColorsData.blue_1, width: 1.0))
            : null,
      ),
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap();
        }
      },
      readOnly: widget.readOnly != null ? widget.readOnly : false,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      controller: _controller,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }
}
