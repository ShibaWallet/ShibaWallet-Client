

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as Foundation;

class Console {

  static void log(Object? object) {
    if (Foundation.kDebugMode) {
      debugPrint(object.toString());
    }
  }

}