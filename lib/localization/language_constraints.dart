import 'package:flutter/material.dart';

import 'localization_manager.dart';

String getTranslated(BuildContext context, String key) {
  return AppLocalization.of(context).translate(key);
}