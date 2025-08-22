import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../utils/application_shared_instance.dart';
import '../models/selection_object.dart';
import '../utils/helper_functions.dart';
import '../utils/app_sharedpref.dart';
import '../services/api_manager.dart';
import '../utils/api_endpoint.dart';
import '../models/user_model.dart';
import '../utils/app_assets.dart';
import '../utils/app_alerts.dart';
import '../utils/print_log.dart';

class DashboardProvider extends ChangeNotifier {
  String appVersion = '';
  String buildNumber = '';
  UserModel userModel = UserModel();

  List<SelectionObject> categories = [
    SelectionObject(id: '1', title: 'All', isSelected: true),
    SelectionObject(id: '2', title: 'New Cars'),
    SelectionObject(id: '3', title: 'Recondition Cars'),
  ];

  List<SelectionObject> topCarBrandsInSaudi = [
    SelectionObject(
      id: '1',
      title: 'Toyota',
      titleAr: 'تويوتا',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Toyota_carlogo.svg/1200px-Toyota_carlogo.svg.png',
      isSelected: false,
    ),
    SelectionObject(
      id: '2',
      title: 'Nissan',
      titleAr: 'نيسان',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Nissan_2020_logo.png/800px-Nissan_2020_logo.png',
      isSelected: false,
    ),
    SelectionObject(
      id: '3',
      title: 'Hyundai',
      titleAr: 'هيونداي',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Hyundai_Motor_Company_logo.svg/1200px-Hyundai_Motor_Company_logo.svg.png',
      isSelected: false,
    ),
    SelectionObject(
      id: '4',
      title: 'Kia',
      titleAr: 'كيا',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Kia_logo.svg/1200px-Kia_logo.svg.png',
      isSelected: false,
    ),
    SelectionObject(
      id: '5',
      title: 'Mitsubishi',
      titleAr: 'ميتسوبيشي',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Mitsubishi_logo.svg/1200px-Mitsubishi_logo.svg.png',
      isSelected: false,
    ),
    SelectionObject(
      id: '6',
      title: 'Mercedes-Benz',
      titleAr: 'مرسيدس بنز',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/1200px-Mercedes-Logo.svg.png',
      isSelected: false,
    ),
    SelectionObject(
      id: '7',
      title: 'BMW',
      titleAr: 'بي ام دبليو',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/BMW.svg/1200px-BMW.svg.png',
      isSelected: false,
    ),
    SelectionObject(
      id: '8',
      title: 'Lexus',
      titleAr: 'لكزس',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Lexus_Logo_2021.png/800px-Lexus_Logo_2021.png',
      isSelected: false,
    ),
    SelectionObject(
      id: '9',
      title: 'Ford',
      titleAr: 'فورد',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Ford_logo_flat.svg/1200px-Ford_logo_flat.svg.png',
      isSelected: false,
    ),
    SelectionObject(
      id: '10',
      title: 'Chevrolet',
      titleAr: 'شفروليه',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Chevrolet_logo_2013.png/800px-Chevrolet_logo_2013.png',
      isSelected: false,
    ),
    SelectionObject(
      id: '11',
      title: 'Jeep',
      titleAr: 'جيب',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Jeep_logo_2013.png/800px-Jeep_logo_2013.png',
      isSelected: false,
    ),
    SelectionObject(
      id: '12',
      title: 'Land Rover',
      titleAr: 'لاند روفر',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/71/Land_Rover_logo_2011.png/800px-Land_Rover_logo_2011.png',
      isSelected: false,
    ),
    SelectionObject(
      id: '13',
      title: 'Porsche',
      titleAr: 'بورش',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Porsche_logo.png/800px-Porsche_logo.png',
      isSelected: false,
    ),
    SelectionObject(
      id: '14',
      title: 'Audi',
      titleAr: 'أودي',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Audi_logo_detail.svg/1200px-Audi_logo_detail.svg.png',
      isSelected: false,
    ),
    SelectionObject(
      id: '15',
      title: 'Volkswagen',
      titleAr: 'فولكس واجن',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Volkswagen_logo_2019.svg/1200px-Volkswagen_logo_2019.svg.png',
      isSelected: false,
    ),
  ];

  List<SelectionObject> genders = [
    SelectionObject(id: '1', title: 'Male'),
    SelectionObject(id: '2', title: 'Female'),
  ];

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    notifyListeners();
  }

  void setUserModel(Map<String, dynamic> data) {
    userModel = UserModel.fromJson(data['user']);
    DataManager().authToken = data['accessToken'];
    HelperFunctions.saveInPreference(
      AppSharedPref.authToken,
      data['accessToken'],
    );
    HelperFunctions.saveInPreference(
      AppSharedPref.userData,
      jsonEncode(userModel),
    );
    notifyListeners();
  }

  Future<void> initApiCalls(BuildContext context) async {
    Future.wait([
      fetchProfile(context),
      fetchCategories(context),
      fetchCities(context),
    ]);
  }

  ///fetch profile
  Future<void> fetchProfile(BuildContext context) async {
    try {
      final response = await ApiManager.get(ApiEndpoint.profile);
      PrintLogs.printLog("fetchProfile: $response");
      if (response['status'] == true) {
        if (response['data'] is Map) {
          userModel = UserModel.fromJson(response['data']);
          HelperFunctions.saveInPreference(
            AppSharedPref.userData,
            jsonEncode(userModel),
          );
        }
      } else {
        HelperFunctions.handleApiMessages(response);
      }
    } catch (e) {
      AppAlerts.showSnackBar(
        'An error occurred: ${e.toString()}',
        statusCode: 1,
      );
    }
  }

  ///fetch Cities
  Future<void> fetchCities(BuildContext context) async {
    try {
      final response = await ApiManager.get(ApiEndpoint.getCities);
      PrintLogs.printLog("fetchCities: $response");
      if (response['status'] == true) {
      } else {
        HelperFunctions.handleApiMessages(response);
      }
    } catch (e) {
      AppAlerts.showSnackBar(
        'An error occurred: ${e.toString()}',
        statusCode: 1,
      );
    }
  }

  ///fetch Cities
  Future<void> fetchCategories(BuildContext context) async {
    try {
      final response = await ApiManager.get(ApiEndpoint.getCategories);
      PrintLogs.printLog("fetchCategories: $response");
      if (response['status'] == true) {
      } else {
        HelperFunctions.handleApiMessages(response);
      }
    } catch (e) {
      AppAlerts.showSnackBar(
        'An error occurred: ${e.toString()}',
        statusCode: 1,
      );
    }
  }
}
