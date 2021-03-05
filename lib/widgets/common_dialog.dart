import 'package:structure_example/resource/dimen.dart';
import 'package:flutter/material.dart';
import 'package:structure_example/resource/texts_stype.dart';
import 'package:structure_example/utils/take_photos.dart';
import 'package:structure_example/widgets/network_photo_view.dart';

typedef OnClickOK();
typedef OnClickYes();
typedef OnClickNo();

Future<T> showOkDialog<T>(@required BuildContext context, @required String text, OnClickOK onClickOK, [bool clickoutSide, Color buttonColor, String textButton]) async => showDialog(
      context: context,
      builder: (conontext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimen.dialogRadius)),
          title: Text(text, textAlign: TextAlign.center),
          titleTextStyle: TextsStyle.title,
          actions: [
            RaisedButton(
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
                if (onClickOK != null) {
                  onClickOK();
                }
              },
              child: Text(textButton ?? "OK"),
            )
          ],
        );
      },
    );

Future<T> showYesNoDialog<T>(@required BuildContext context, @required String text, OnClickOK onClickOK, [bool clickoutSide, Color buttonColor, String textButton]) async {}

void showPhotoView(BuildContext context, final List<String> imageUrls, final int initIndex) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NetworkPhotoView(
        imageUrls: imageUrls,
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        initialIndex: initIndex,
        scrollDirection: Axis.horizontal,
      ),
    ),
  );
}

Future<PickerSource> showPickerSource(BuildContext context) async {
  var result = await showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pop(PickerSource.CAMERA);
            },
            child: Text("Chụp ảnh"),
          ),
          SizedBox(
            height: 15,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pop(PickerSource.GALLERY);
            },
            child: Text("Thư viện ảnh"),
          ),
          SizedBox(
            height: 15,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pop(PickerSource.FILE);
            },
            child: Text("Tập tin"),
          ),
          Spacer(),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pop(PickerSource.NONE);
            },
            child: Text("Huỷ"),
            color: Colors.red[400],
          ),
        ],
      ),
    ),
  );
  return result ?? PickerSource.NONE;
}
