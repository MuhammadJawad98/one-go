// Singleton class

import 'package:flutter/material.dart';

class DataManager {

  static final DataManager _singleton = DataManager._internal();

  factory DataManager() {
    return _singleton;
  }

  String baseUrlAssets = '';
  String authToken = '';
  String userRole = '';
  // List<String> companyIds = [];
  // List<String> vendors = [ 'vFairs' ];
  // UserObject user = UserObject();

  List<Locale> languageList = [
    const Locale('en'),
    const Locale('ar'),
    // const Locale('ur'),
  ];

  DataManager._internal();
}