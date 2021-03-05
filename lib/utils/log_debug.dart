import 'package:flutter/foundation.dart';

log(dynamic mess, [String title]) {
  if (kDebugMode) {
    print("\x1B[31m|-->\x1B[0m ${title ?? ""}: ${mess.toString()}");
  }
}
