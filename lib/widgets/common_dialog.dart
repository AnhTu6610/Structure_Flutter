import 'package:structure_example/resource/dimen.dart';
import 'package:structure_example/resource/fonts_name.dart';
import 'package:structure_example/resource/fonts_size.dart';
import 'package:flutter/material.dart';

typedef OnClickOK();
typedef OnClickYes();
typedef OnClickNo();

Future<T> showOkDialog<T>(
    @required BuildContext context,
    String text,
    OnClickOK onClickOK,
    bool clickoutSide,
    Color buttonColor,
    String textButton) async {
  await showGeneralDialog(
    barrierColor: Colors.black.withOpacity(0.5),
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimen.borderRadious),
            ),
            title: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontsSize.small_3,
                fontFamily: FontsName.nunito_Regular,
              ),
            ),
            content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: RaisedButton(
                onPressed: () {
                  if (onClickOK != null) {
                    onClickOK();
                  }
                },
                color: buttonColor,
                child: Text(
                  textButton,
                ),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionDuration: Duration(milliseconds: 200),
    barrierDismissible: clickoutSide,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation1, animation2) {},
  );
}
