import 'dart:developer';

import 'package:flutter/foundation.dart';

class PrintLogs {
  static void printMessage(dynamic message) {
     if (kDebugMode) {
       print('$message');
     }
  }

   static void printLog(dynamic message) {
    if (kDebugMode) {
       log('$message');
    }
  }

}
