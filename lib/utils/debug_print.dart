import 'package:flutter/foundation.dart';

debugPrint(dynamic mess, [String title]) {
  if (kDebugMode) {
    print("|--> " + (title ?? "") + ": " + mess.toString());
  }
}
