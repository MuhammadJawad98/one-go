import 'package:flutter/material.dart';

import '../models/selection_object.dart';
import '../utils/app_sharedpref.dart';
import '../utils/application_shared_instance.dart';
import '../utils/helper_functions.dart';

class LanguageProvider extends ChangeNotifier {

  LanguageProvider(){
    _initializeLanguageFunc();
  }
  int _selectedIndex = 0;
  Locale _appLanguage = const Locale('en', 'US');
  final List<SelectionObject> _languageList = [
    SelectionObject(
      id: '1',
      title: 'English',
      value: 'en',
      others: 'US'
    ),
    SelectionObject(
      id: '2',
      title: 'عربی',
      value: 'ar',
      others: 'SA'
    ),
    // SelectionObject(
    //     id: '3',
    //     title: 'اردو',
    //     value: 'ur',
    //     others: 'PK'
    // ),
  ];

  int get selectedIndex => _selectedIndex;
  Locale get appLanguage => _appLanguage;
  List<SelectionObject> get languageList => _languageList;

  void _initializeLanguageFunc(){
    _selectedIndex = 0;
    HelperFunctions.getFromPreference(AppSharedPref.appLanguage).then((name){
      if(name!= ""){
        _selectedIndex = DataManager().languageList.indexWhere((element) => element.languageCode == name);
        if(_selectedIndex == -1){
          _selectedIndex = 0;
        }
        _appLanguage = DataManager().languageList[_selectedIndex];
      }else{
       _appLanguage = DataManager().languageList[_selectedIndex];
      }
      notifyListeners();
    });
  }

  void changeAppLanguage(int index){
    _selectedIndex = index;
    _appLanguage = DataManager().languageList[_selectedIndex];
    HelperFunctions.saveInPreference(AppSharedPref.appLanguage, DataManager().languageList[_selectedIndex].languageCode);
    notifyListeners();
  }

  

}