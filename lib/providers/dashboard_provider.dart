import 'dart:convert';
import 'dart:io';

import 'package:car_wash_app/models/attachement_model.dart';
import 'package:car_wash_app/models/car_model.dart';
import 'package:car_wash_app/models/services_model.dart';
import 'package:car_wash_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../models/car_detail_model.dart';
import '../models/category_model.dart';
import '../models/selection_object.dart';
import '../models/service_detail_model.dart';
import '../models/user_model.dart';
import '../services/api_manager.dart';
import '../utils/api_endpoint.dart';
import '../utils/app_alerts.dart';
import '../utils/app_sharedpref.dart';
import '../utils/application_shared_instance.dart';
import '../utils/helper_functions.dart';
import '../utils/print_log.dart';

class DashboardProvider extends ChangeNotifier {
  String appVersion = '';
  String buildNumber = '';
  bool isProfileUpdating = false;
  bool isCarDetailLoading = false;
  bool hasMore = true;
  bool isLoading = false;
  bool isServicesLoading = false;
  UserModel userModel = UserModel();
  Attachment attachment = Attachment();
  CarDetailsModel carDetailsModel = CarDetailsModel();
  ServiceDetailModel serviceDetail = ServiceDetailModel();
  List<CarsModel> carsList = [];
  List<CarsModel> searchedCarsList = [];
  int currentPage = 1;
  int totalCars = 0;
  int totalSearchedCars = 0;
  List<ServiceModel> servicesList = [];
  List<Category> categories = [];
  List<SelectionObject> categoryList = [];
  List<SelectionObject> cities = [];
  List<SelectionObject> makes = [];
  List<SelectionObject> models = [];
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
      id: '9',
      title: 'Ford',
      titleAr: 'فورد',
      image:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Ford_logo_flat.svg/1200px-Ford_logo_flat.svg.png',
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
      id: '8',
      title: 'Lexus',
      titleAr: 'لكزس',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Lexus_Logo_2021.png/800px-Lexus_Logo_2021.png',
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
      fetchCars(context,fromHomeScreen: true),
    ]);
    notifyListeners();
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
        Provider.of<AuthProvider>(context,listen: false).logout(context);
      }
    } catch (e) {
      AppAlerts.showSnackBar(
        'An error occurred: ${e.toString()}',
        statusCode: 1,
      );
    }
  }

  ///update profile
  Future<void> updateProfile(BuildContext context, UserModel obj) async {
    try {
      var body = {
        "mobile": obj.mobile,
        "name": obj.name,
        "email": obj.email,
        "attachmentId": obj.attachment?.id != ""
            ? int.parse(obj.attachment!.id)
            : "",
      };
      updateProfileLoader(true);
      final response = await ApiManager.update(ApiEndpoint.updateProfile, body);
      updateProfileLoader(false);
      PrintLogs.printLog("fetchProfile: $response");
      if (response['status'] == true) {
        // if (response['data'] is Map) {
        //   userModel = UserModel.fromJson(response['data']);
        //   HelperFunctions.saveInPreference(
        //     AppSharedPref.userData,
        //     jsonEncode(userModel),
        //   );
        // }
      } else {
        HelperFunctions.handleApiMessages(response);
      }
    } catch (e) {
      AppAlerts.showSnackBar(
        'An error occurred: ${e.toString()}',
        statusCode: 1,
      );
      updateProfileLoader(false);
    }
  }

  Future<bool> uploadAttachment(BuildContext context, File file) async {
    try {
      final response = await ApiManager.uploadFile(
        ApiEndpoint.attachmentsUpload,
        file,
        fieldName: "file",
      );

      PrintLogs.printLog("uploadAttachment response: $response");
      attachment = Attachment();

      if (response['status'] == true) {
        if (response['data']['attachment'] is Map) {
          attachment = Attachment.fromJson(response['data']['attachment']);
        }
        return true;
        // AppAlerts.showSnackBar("Attachment uploaded successfully!");
      } else {
        HelperFunctions.handleApiMessages(response);
      }
    } catch (e) {
      AppAlerts.showSnackBar('Upload failed: ${e.toString()}', statusCode: 1);
    }
    return false;
  }

  /// Initialize all common data
  Future<void> initializeCommonData({bool showLoading = true}) async {
    try {
      // Execute all API calls concurrently
      await Future.wait([
        _fetchCities(),
        _fetchMakes(),
        _fetchCategories(),
      ], eagerError: true);

    } catch (e) {
      PrintLogs.printLog("initializeCommonData error: $e");
    } finally {
      notifyListeners();
    }
  }

  /// Fetch cities
  Future<void> _fetchCities() async {
    try {
      final response = await ApiManager.get(ApiEndpoint.getCities);
      PrintLogs.printLog("fetchCities: $response");

      if (response['status'] == true) {
        if (response['data'] is List) {
          cities.clear();
          for (var item in response['data']) {
            cities.add(SelectionObject(id: item['id']?.toString() ?? '', title:  item['name']?.toString() ?? '', value:  item['slug']?.toString() ?? ''));
          }
        }
      }
    } catch (e) {
      PrintLogs.printLog("fetchCities error: $e");
    }
  }

  /// Fetch makes
  Future<void> _fetchMakes() async {
    try {
      final response = await ApiManager.get(ApiEndpoint.carsMakes); // Fixed endpoint
      PrintLogs.printLog("fetchMakes: $response");

      if (response['status'] == true) {
        if (response['data'] is List) {
          makes.clear();
          for (var item in response['data']) {
            makes.add(SelectionObject(id: item['id']?.toString() ?? '', title:  item['name']?.toString() ?? '', value:  item['slug']?.toString() ?? '', isActive: item['isActive'] == true));
          }
        }
      }
    } catch (e) {
      PrintLogs.printLog("fetchMakes error: $e");
    }
  }

  ///fetch models
  Future<void> fetchModels(BuildContext context, String makeId) async {
    try {
      final response = await ApiManager.get("${ApiEndpoint.carsMakes}/$makeId/models"); // Fixed endpoint
      PrintLogs.printLog("fetchModels: $response");

      if (response['status'] == true) {
        if (response['data'] is List) {
          models.clear();
          for (var item in response['data']) {
            models.add(SelectionObject(id: item['id']?.toString() ?? '', title:  item['name']?.toString() ?? '', value:  item['slug']?.toString() ?? '', isActive: item['isActive'] == true));
          }
        }
      }
    } catch (e) {
      PrintLogs.printLog("fetchMakes error: $e");
    }
  }

  /// Fetch categories
  Future<void> _fetchCategories() async {
    try {
      final response = await ApiManager.get(ApiEndpoint.getCategories);
      PrintLogs.printLog("fetchCategories: $response");

      if (response['status'] == true) {
        if (response['data'] is List) {
          categories.clear();
          categoryList.clear();
          for (var item in response['data']) {
            categories.add(Category.fromJson(item));
            categoryList.add(SelectionObject(id: item['id']?.toString() ?? '', title:  item['name']?.toString() ?? '', value:  item['slug']?.toString() ?? '', isActive: item['isActive'] == true));
          }
          if (categories.isNotEmpty) {
            categories[0].isSelected = true;
          }
        }
      } else {
        HelperFunctions.handleApiMessages(response);
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      PrintLogs.printLog("fetchCategories error: $e");
      rethrow;
    }
  }

  /// Individual refresh methods if needed
  Future<void> refreshCities() async => await _fetchCities();
  Future<void> refreshMakes() async => await _fetchMakes();
  Future<void> refreshCategories() async => await _fetchCategories();

  /// Clear all data
  void clearData() {
    categories.clear();
    cities.clear();
    makes.clear();
    notifyListeners();
  }


  Future<void> fetchCars(
    BuildContext context, {
    int limit = 20,
    String? sortBy,
    String? sortOrder,
    String? conditionType,
    String? regionalSpecs,
    String? optionalLevel,
    String? bodyType,
    // String? transmission,
    String? driveType,
    // String? fuelType,
    String? cylinders,
    String? overallCondition,
    String? accidentHistory,
    String? airBagsCondition,
    String? chassisCondition,
    String? engineCondition,
    String? gearBoxCondition,
    String? roofType,
    String? color,
    String? makeId,
    String? makeSlug,
    String? make,
    String? modelId,
    String? model,
    String? modelSlug,
    String? cityId,
    String? citySlug,
    String? minPrice,
    String? maxPrice,
    String? minMileage,
    String? maxMileage,
    String? minYear,
    String? maxYear,
    String? keywords,
    String? keyword,
    bool? isFeatured,
    bool reset = false,
    bool fromHomeScreen = false,
    List<SelectionObject>? fuelTypes,
    List<SelectionObject>? transmissionType,
  }) async {
    if (isLoading) return;
    isLoading = true;

    try {
      if (reset) {
        currentPage = 1;
        hasMore = true;
      }
      if(fromHomeScreen){
        carsList.clear();
      }
      searchedCarsList.clear();

      final queryParams = <String, String>{};

// your existing single-value params
    queryParams.addAll({
      'page': currentPage.toString(),
      'limit': limit.toString(),
      if (sortBy != null && sortBy.isNotEmpty) 'sortBy': sortBy,
      if (sortOrder != null && sortOrder.isNotEmpty) 'sortOrder': sortOrder,
      if (conditionType != null && conditionType.isNotEmpty) 'conditionType': conditionType,
      if (regionalSpecs != null && regionalSpecs.isNotEmpty) 'regionalSpecs': regionalSpecs,
      if (optionalLevel != null && optionalLevel.isNotEmpty) 'optionalLevel': optionalLevel,
      if (bodyType != null && bodyType.isNotEmpty) 'bodyType': bodyType,
      if (driveType != null && driveType.isNotEmpty) 'driveType': driveType,
      if (cylinders != null && cylinders.isNotEmpty) 'cylinders': cylinders,
      if (overallCondition != null && overallCondition.isNotEmpty) 'overallCondition': overallCondition,
      if (accidentHistory != null && accidentHistory.isNotEmpty) 'accidentHistory': accidentHistory,
      if (airBagsCondition != null && airBagsCondition.isNotEmpty) 'airBagsCondition': airBagsCondition,
      if (chassisCondition != null && chassisCondition.isNotEmpty) 'chassisCondition': chassisCondition,
      if (engineCondition != null && engineCondition.isNotEmpty) 'engineCondition': engineCondition,
      if (gearBoxCondition != null && gearBoxCondition.isNotEmpty) 'gearBoxCondition': gearBoxCondition,
      if (roofType != null && roofType.isNotEmpty) 'roofType': roofType,
      if (color != null && color.isNotEmpty) 'color': color,
      if (makeId != null && makeId.isNotEmpty) 'makeId': makeId,
      if (makeSlug != null && makeSlug.isNotEmpty) 'makeSlug': makeSlug,
      if (modelId != null && modelId.isNotEmpty) 'modelId': modelId,
      if (modelSlug != null && modelSlug.isNotEmpty) 'modelSlug': modelSlug,
      if (cityId != null && cityId.isNotEmpty) 'cityId': cityId,
      if (citySlug != null && citySlug.isNotEmpty) 'citySlug': citySlug,
      if (minPrice != null && minPrice.isNotEmpty) 'minPrice': minPrice,
      if (maxPrice != null && maxPrice.isNotEmpty) 'maxPrice': maxPrice,
      if (minMileage != null && minMileage.isNotEmpty) 'minMileage': minMileage,
      if (maxMileage != null && maxMileage.isNotEmpty) 'maxMileage': maxMileage,
      if (minYear != null && minYear.isNotEmpty) 'minYear': minYear,
      if (maxYear != null && maxYear.isNotEmpty) 'maxYear': maxYear,
      if (keywords != null && keywords.isNotEmpty) 'keywords': keywords,
      if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
      if (isFeatured != null) 'isFeatured': isFeatured.toString(),
    });

// build query manually
    final queryBuffer = StringBuffer();

    queryParams.forEach((key, value) {
      queryBuffer.write('${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(value)}&');
    });

// add multi-select fuel types
    if (fuelTypes != null) {
      for (final f in fuelTypes.where((e) => e.isSelected)) {
        queryBuffer.write('fuelType=${Uri.encodeQueryComponent(f.title.toLowerCase())}&');
      }
    }

// add multi-select transmission types
    if (transmissionType != null) {
      for (final t in transmissionType.where((e) => e.isSelected)) {
        queryBuffer.write('transmission=${Uri.encodeQueryComponent(t.title.toLowerCase())}&');
      }
    }

// remove last &
    final queryString = queryBuffer.toString().replaceAll(RegExp(r'&$'), '');

    final uri = Uri.parse('${ApiEndpoint.carsSearch}?$queryString');

    final response = await ApiManager.get(uri.toString());

      if (response['status'] == true &&
          response['data'] is Map &&
          response['data']['data'] is List) {
        final List<dynamic> carList = response['data']['data'] ?? [];
        final bool next = response['data']['hasNext'] ?? false;

        if (carList.isNotEmpty) {
          if(!fromHomeScreen){
            searchedCarsList.addAll(carList.map((e) => CarsModel.fromJson(e)).toList());
            PrintLogs.printLog("searchedCarsList: ${searchedCarsList.length}");
            if(response['data']['total'] is int){
              totalSearchedCars = response['data']['total'];
            }
          }else{
            carsList.addAll(carList.map((e) => CarsModel.fromJson(e)).toList());
            if(response['data']['total'] is int){
              totalCars = response['data']['total'];
            }
          }
        }else{
         if(!fromHomeScreen) totalSearchedCars = 0;
        }


        if (next) {
          currentPage++; // ✅ only increment if API says more pages
        } else {
          hasMore = false;
        }
      } else {
        HelperFunctions.handleApiMessages(response);
      }
    } catch (e) {
      AppAlerts.showSnackBar(
        'An error occurred: ${e.toString()}',
        statusCode: 1,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void onCategorySelection(int index) {
    for (int i = 0; i < categories.length; i++) {
      if (i == index) {
        categories[i].isSelected = true;
      } else {
        categories[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  void uploadUserPic(
    BuildContext context,
    File file, {
    bool fromProfile = false,
  }) async {
    updateProfileLoader(true);
    var result = await uploadAttachment(context, file);
    PrintLogs.printLog("upload user pic: $result");
    updateProfileLoader(false);
    if (result && fromProfile) {
      var obj = userModel;
      obj.attachment = attachment;
      await updateProfile(context, obj);
    }
  }

  void updateProfileLoader(bool val) {
    isProfileUpdating = val;
    notifyListeners();
  }

  void updateCarDetailLoader(bool val){
    isCarDetailLoading = val;
    notifyListeners();
  }

  void fetchCarDetails(BuildContext context, CarsModel obj) async{
    carDetailsModel = CarDetailsModel();
     updateProfileLoader(true);
    try{
      final response = await ApiManager.get('${ApiEndpoint.cars}/${obj.id}');
      PrintLogs.printLog("fetchCarDetails response: $response");
      if (response['status'] == true && response['data'] is Map) {
        carDetailsModel = CarDetailsModel.fromJson(response['data']);
      }else{
        carDetailsModel = CarDetailsModel();
      }
    }catch(e){
      PrintLogs.printLog('Exception fetchCarDetails : $e');
      carDetailsModel = CarDetailsModel();
    }finally{
      updateProfileLoader(true);
    }
  }

  void updateServicesLoader(bool val){
    isServicesLoading = val;
    notifyListeners();
  }

  // void fetchServices(BuildContext context) async{
  //   servicesList.clear();
  //   updateServicesLoader(true);
  //   try{
  //     final response = await ApiManager.get(ApiEndpoint.serviceSearch);
  //     PrintLogs.printLog("fetchServices response: $response");
  //     if (response['status'] == true) {
  //       if(response['data']['data'] is List){
  //         List data = response['data']['data'] as List;
  //         for (var e in data) {
  //           servicesList.add(ServiceModel.fromJson(e));
  //         }
  //       }
  //     }else{
  //       HelperFunctions.handleApiMessages(response);
  //     }
  //   }catch(e){
  //     PrintLogs.printLog('Exception fetchServices : $e');
  //   }finally{
  //     updateServicesLoader(false);
  //   }
  // }

  Future<void> fetchServices(
      BuildContext context, {
        String? search,
        String? citySlug,
        String? categorySlug,
        String? minPrice,
        String? maxPrice,
        bool reset = false,
        // String? page,
        // String? perPage,

      }) async {
    servicesList.clear();
    updateServicesLoader(true);

    try {

    // http://144.91.76.33:3002/api/v1/services/search?page=1&limit=9&sortBy=latest&citySlug=dammam&minPrice=1&maxPrice=135001

    final uri = Uri.parse(ApiEndpoint.serviceSearch).replace(
        queryParameters: {
          'page': reset ? '1': currentPage.toString(),
          'limit': '100',
          // 'sortBy': 'latest',
          if (search != null && search.trim().isNotEmpty) 'search' : search.trim(),
          if (citySlug != null && citySlug.trim().isNotEmpty) 'citySlug' : citySlug.trim(),
          if (categorySlug != null && categorySlug.trim().isNotEmpty) 'categorySlug' : categorySlug.trim(),
          if (minPrice != null) 'minPrice' : minPrice.trim(),
          if (maxPrice != null) 'maxPrice' : maxPrice.trim(),
        },
      );

      final response = await ApiManager.get(uri.toString());

      PrintLogs.printLog("fetchServicesFiltered response: $response");

      if (response['status'] == true) {
        final data = response['data']?['data'];
        if (data is List) {
          servicesList.addAll(data.map<ServiceModel>((e) => ServiceModel.fromJson(e)));
        }
      } else {
        HelperFunctions.handleApiMessages(response);
      }
    } catch (e) {
      PrintLogs.printLog('Exception fetchServicesFiltered : $e');
    } finally {
      updateServicesLoader(false);
    }
  }


  void fetchServiceDetails(BuildContext context, String serviceId) async{
    serviceDetail = ServiceDetailModel();
    updateServicesLoader(true);
    try{
      final response = await ApiManager.get("${ApiEndpoint.services}/$serviceId");
      PrintLogs.printLog("fetchServices response: $response");
      if (response['status'] == true) {
        if(response['data'] is Map){
          serviceDetail = ServiceDetailModel.fromJson(response['data']);
        }
      }else{
        HelperFunctions.handleApiMessages(response);
      }
    }catch(e){
      PrintLogs.printLog('Exception fetchServices : $e');
    }finally{
      updateServicesLoader(false);
    }
  }
}
