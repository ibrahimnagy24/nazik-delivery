import 'package:flutter_base/helpers/media_query_helper.dart';

abstract class KeyboardOperations {
  static bool isKeyboardOpen() {
    if (MediaQueryHelper.appMediaQueryViewInsets.bottom == 0.0) {
      return false;
    } else {
      return true;
    }
  }
}
