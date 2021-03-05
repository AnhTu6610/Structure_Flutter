import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

enum PickerSource { CAMERA, GALLERY, FILE, NONE }

class TakePhotos {
  ImagePicker picker = new ImagePicker();

  Future<File> getImage(PickerSource source) async {
    if (source == PickerSource.CAMERA || source == PickerSource.GALLERY) {
      PickedFile pickedFile = await picker.getImage(
        source: source == PickerSource.CAMERA ? ImageSource.camera : ImageSource.gallery,
      );
      if (pickedFile == null) return null;

      File image = File(pickedFile.path);
      return image;
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path);
        return file;
      } else
        return null;
    }
  }
}
