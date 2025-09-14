import 'dart:io';

import 'package:car_wash_app/models/car_basic_model.dart';
import 'package:car_wash_app/models/selection_object.dart';
import 'package:car_wash_app/providers/dashboard_provider.dart';
import 'package:car_wash_app/utils/app_alerts.dart';
import 'package:car_wash_app/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/car_image_selection_model.dart';
import '../services/api_manager.dart';
import '../utils/api_endpoint.dart';
import '../utils/print_log.dart';
import 'car_listing_provider.dart';

class MyCarsProvider extends ChangeNotifier {
  bool isLoading = false;
  bool hasAlloyRims = false;
  bool currentlyFinanced = false;
  bool firstOwner = false;

  List<SelectionObject> makeList = [];
  List<SelectionObject> modelList = [];
  List<SelectionObject> yearList = [];
  List<SelectionObject> mileageList = [];
  List<SelectionObject> conditionList = [];
  List<SelectionObject> regionalSpecsList = [];
  List<SelectionObject> bodyTypeList = [];
  List<SelectionObject> transmissionList = [];
  List<SelectionObject> fuelTypeList = [];
  List<SelectionObject> colorList = [];
  List<SelectionObject> cylinderList = [];
  List<SelectionObject> cityList = [];
  List<SelectionObject> driveTypeList = [];
  List<SelectionObject> engineSizeList = [];
  List<SelectionObject> optionalLevelList = [];

  List<SelectionObject> overAllConditionList = [
    SelectionObject(title: 'Good Condition', value: 'good_condition'),
    SelectionObject(title: 'Average Condition', value: 'average_condition'),
    SelectionObject(title: 'Bad Condition', value: 'bad_condition'),
  ];
  List<SelectionObject> accidentHistoryList = [
    SelectionObject(title: 'Never', value: 'never'),
    SelectionObject(title: 'Minor', value: 'minor'),
    SelectionObject(title: 'Major', value: 'major'),
  ];
  List<SelectionObject> airBagsConditionList = [
    SelectionObject(title: 'Original', value: 'original'),
    SelectionObject(
      title: 'Damaged/Repaired/Replaced',
      value: 'damaged_repaired_replaced',
    ),
    SelectionObject(
      title: 'Damaged (Not Repaired)',
      value: 'damaged_not_repaired',
    ),
  ];
  List<SelectionObject> chassisConditionList = [
    SelectionObject(title: 'Original', value: 'original'),
    SelectionObject(
      title: 'Damaged/Repaired/Replaced',
      value: 'damaged_repaired_replaced',
    ),
    SelectionObject(
      title: 'Damaged (Not Repaired)',
      value: 'damaged_not_repaired',
    ),
  ];
  List<SelectionObject> engineConditionList = [
    SelectionObject(title: 'Original', value: 'original'),
    SelectionObject(
      title: 'Damaged/Repaired/Replaced',
      value: 'damaged_repaired_replaced',
    ),
    SelectionObject(
      title: 'Damaged (Not Repaired)',
      value: 'damaged_not_repaired',
    ),
  ];
  List<SelectionObject> gearBoxConditionList = [
    SelectionObject(title: 'Original', value: 'original'),
    SelectionObject(
      title: 'Damaged/Repaired/Replaced',
      value: 'damaged_repaired_replaced',
    ),
    SelectionObject(
      title: 'Damaged (Not Repaired)',
      value: 'damaged_not_repaired',
    ),
  ];
  List<SelectionObject> roofTypeList = [
    SelectionObject(title: 'Sunroof', value: 'sunroof'),
    SelectionObject(title: 'Softtop Convertible', value: 'softtop_convertible'),
    SelectionObject(title: 'Hardtop Covertible', value: 'hardtop_convertible'),
    SelectionObject(title: 'Panoramic', value: 'panoramic'),
    SelectionObject(title: 'Moonroof', value: 'moonroof'),
    SelectionObject(title: 'Regular', value: 'regular'),
    SelectionObject(title: 'Sunroof & Moonroof', value: 'sunroof_moonroof'),
  ];
  List<SelectionObject> safetyFeature = [];
  List<SelectionObject> exteriorFeatures = [];
  List<SelectionObject> entertainmentConnectivity = [];
  List<SelectionObject> driverAssistance = [];
  List<SelectionObject> interiorComfort = [];
  List<SelectionObject> maintenanceModifications = [];
  List<SelectionObject> selectedFeatureItems = [];

  SelectionObject? make;
  SelectionObject? model;
  SelectionObject? year;
  String? mileage;
  SelectionObject? condition;
  SelectionObject? regionSpec;
  SelectionObject? bodyType;
  SelectionObject? transmission;
  SelectionObject? fuelType;
  SelectionObject? color;
  SelectionObject? cylinder;
  SelectionObject? city;
  String? variant;
  String? noOfSeats;
  SelectionObject? driveType;
  SelectionObject? engineSize;
  SelectionObject? optionalLevel;
  CarBasicModel carBasicModel = CarBasicModel();

  ///step2
  SelectionObject? overAllCondition;
  SelectionObject? accidentHistory;
  SelectionObject? airBagsCondition;
  SelectionObject? chassisCondition;
  SelectionObject? engineCondition;
  SelectionObject? gearBoxCondition;
  SelectionObject? roofType;
  String specialAboutCar = '';
  String accidentDetails = '';
  String rimSize = '';

  ///step 4
  List<CarImagesSelectionModel> carImages = [];
  List<SelectionObject> carImageTypes = [
    SelectionObject(title: 'Front Exterior', value: 'exterior_front'),
    SelectionObject(title: 'Rear Exterior', value: 'exterior_back'),
    SelectionObject(title: 'Left Side Exterior', value: 'exterior_left'),
    SelectionObject(title: 'Right Side Exterior', value: 'exterior_right'),
    SelectionObject(title: 'Interior Front', value: 'interior_front'),
    SelectionObject(title: 'Interior Back', value: 'interior_back'),
    SelectionObject(title: 'Engine', value: 'engine'),
    SelectionObject(title: 'Dashboard', value: 'dashboard'),
    SelectionObject(title: 'Odometer', value: 'odometer'),
    SelectionObject(title: 'Registration', value: 'registration'),
    SelectionObject(title: 'Insurance', value: 'insurance'),
    SelectionObject(title: 'Trunk', value: 'trunk'),
    SelectionObject(title: 'Other', value: 'other'),
  ];

  ///step5
  TextEditingController priceController = TextEditingController();
  bool isFeatureSelected = false;

  void resetAll() {
    isLoading = false;
    makeList = [];
    modelList = [];
    yearList = [];
    mileageList = [];
    conditionList = [];
    regionalSpecsList = [];
    bodyTypeList = [];
    transmissionList = [];
    fuelTypeList = [];
    colorList = [];
    cylinderList = [];
    cityList = [];
    driveTypeList = [];
    engineSizeList = [];
    optionalLevelList = [];
    for (var e in safetyFeature) {
      e.isSelected = false;
    }
    for (var e in exteriorFeatures) {
      e.isSelected = false;
    }
    for (var e in entertainmentConnectivity) {
      e.isSelected = false;
    }
    for (var e in driverAssistance) {
      e.isSelected = false;
    }
    for (var e in interiorComfort) {
      e.isSelected = false;
    }
    for (var e in maintenanceModifications) {
      e.isSelected = false;
    }
    carBasicModel = CarBasicModel();
  }

  void init(BuildContext context) {
    resetAll();
    var dashboardProvider = Provider.of<DashboardProvider>(
      context,
      listen: false,
    );
    makeList = dashboardProvider.makes;
    yearList = generateYearSelections();
    conditionList = [
      SelectionObject(title: 'New', value: 'new'),
      SelectionObject(title: 'Used', value: 'used'),
    ];
    regionalSpecsList = [
      SelectionObject(title: 'Saudi', value: 'saudi'),
      SelectionObject(title: 'GCC', value: 'gcc'),
      SelectionObject(title: 'American', value: 'american'),
      SelectionObject(title: 'Japanese', value: 'japanese'),
      SelectionObject(title: 'Canadian', value: 'canadian'),
      SelectionObject(title: 'Chinese', value: 'chinese'),
      SelectionObject(title: 'European', value: 'european'),
      SelectionObject(title: 'Korean', value: 'korean'),
      SelectionObject(title: 'Other', value: 'other'),
    ];
    bodyTypeList = [
      SelectionObject(title: 'SUV', value: 'suv'),
      SelectionObject(title: 'Sedan', value: 'sedan'),
      SelectionObject(title: 'Coupe', value: 'coupe'),
      SelectionObject(title: 'Hatchback', value: 'hatchback'),
      SelectionObject(title: 'Convertible', value: 'convertible'),
      SelectionObject(title: 'Minivan', value: 'minivan'),
      SelectionObject(title: 'Pickup', value: 'pickup'),
      SelectionObject(title: 'Van', value: 'van'),
      SelectionObject(title: 'Wagon', value: 'wagon'),
      SelectionObject(title: 'other', value: 'other'),
    ];
    transmissionList = [
      SelectionObject(title: 'Automatic', value: 'automatic'),
      SelectionObject(title: 'Manual', value: 'manual'),
    ];
    fuelTypeList = [
      SelectionObject(title: 'Petrol', value: 'petrol'),
      SelectionObject(title: 'Diesel', value: 'diesel'),
      SelectionObject(title: 'Electric', value: 'electric'),
      SelectionObject(title: 'Hybrid', value: 'hybrid'),
    ];
    colorList = [
      SelectionObject(title: 'Black', value: 'black'),
      SelectionObject(title: 'White', value: 'white'),
      SelectionObject(title: 'Red', value: 'red'),
      SelectionObject(title: 'Blue', value: 'blue'),
      SelectionObject(title: 'Green', value: 'green'),
      SelectionObject(title: 'Yellow', value: 'yellow'),
      SelectionObject(title: 'Grey', value: 'grey'),
      SelectionObject(title: 'Silver', value: 'silver'),
      SelectionObject(title: 'Gold', value: 'gold'),
      SelectionObject(title: 'Brown', value: 'brown'),
      SelectionObject(title: 'Pink', value: 'pink'),
      SelectionObject(title: 'Burgundy', value: 'burgundy'),
      SelectionObject(title: 'Orange', value: 'orange'),
      SelectionObject(title: 'Purple', value: 'purple'),
      SelectionObject(title: 'other', value: 'other'),
    ];

    cylinderList = [
      SelectionObject(title: 'I3', value: 'i3'),
      SelectionObject(title: 'I4', value: 'i4'),
      SelectionObject(title: 'I5', value: 'i5'),
      SelectionObject(title: 'I6', value: 'i6'),
      SelectionObject(title: 'V3', value: 'v3'),
      SelectionObject(title: 'V4', value: 'v4'),
      SelectionObject(title: 'V6', value: 'v6'),
      SelectionObject(title: 'V8', value: 'v8'),
      SelectionObject(title: 'V10', value: 'v10'),
      SelectionObject(title: 'V12', value: 'v12'),
      SelectionObject(title: 'W12', value: 'w12'),
      SelectionObject(title: 'W16', value: 'w16'),
      SelectionObject(title: 'F4', value: 'f4'),
      SelectionObject(title: 'F6', value: 'f6'),
      SelectionObject(title: 'F8', value: 'f8'),
      SelectionObject(title: 'Other', value: 'other'),
    ];
    cityList = dashboardProvider.cities;
    driveTypeList = [
      SelectionObject(title: 'AWD', value: 'awd'),
      SelectionObject(title: 'FWD', value: 'fwd'),
      SelectionObject(title: 'RWD', value: 'rwd'),
      SelectionObject(title: '4WD', value: '4wd'),
      SelectionObject(title: '2WD', value: '2wd'),
    ];
    engineSizeList = [
      SelectionObject(title: '0.5L', value: '0.5L'),
      SelectionObject(title: '1L', value: '1L'),
      SelectionObject(title: '1.5L', value: '1.5L'),
      SelectionObject(title: '2L', value: '2L'),
      SelectionObject(title: '2.5L', value: '2.5L'),
      SelectionObject(title: '3L', value: '3L'),
      SelectionObject(title: '3.5L', value: '3.5L'),
      SelectionObject(title: '4L', value: '4L'),
      SelectionObject(title: '4.5L', value: '4.5L'),
      SelectionObject(title: '5L', value: '5L'),
      SelectionObject(title: '5.5L', value: '5.5L'),
      SelectionObject(title: '6L', value: '6L'),
      SelectionObject(title: '6.5L', value: '6.5L'),
      SelectionObject(title: '7L', value: '7L'),
      SelectionObject(title: '7.5L', value: '7.5L'),
      SelectionObject(title: '8L', value: '8L'),
      SelectionObject(title: '8.5L', value: '8.5L'),
      SelectionObject(title: '9L', value: '9L'),
      SelectionObject(title: '9.5L', value: '9.5L'),
      SelectionObject(title: '10L', value: '10L'),
    ];
    optionalLevelList = [
      SelectionObject(title: 'Based', value: 'based'),
      SelectionObject(title: 'Semi Loaded', value: 'semi_loaded'),
      SelectionObject(title: 'Fully Loaded', value: 'fully_loaded'),
    ];

    notifyListeners();
  }

  initFeatureList() {
    safetyFeature = [
      SelectionObject(title: 'Blind Spot Monitor', value: 'blindSpotMonitor'),
      SelectionObject(title: 'Lane Keep Assist', value: 'laneKeepAssist'),
      SelectionObject(
        title: 'Pre-Collision System',
        value: 'preCollisionSystem',
      ),
      SelectionObject(title: 'Brake Assist', value: 'brakeAssist'),
    ];

    exteriorFeatures = [
      SelectionObject(title: 'LED Headlights', value: 'ledHeadlights'),
      SelectionObject(title: 'Lane Keep Assist', value: 'laneKeepAssist'),
    ];

    entertainmentConnectivity = [
      SelectionObject(title: 'Bluetooth', value: 'bluetooth'),
      SelectionObject(title: 'Apple CarPlay', value: 'carplay'),
      SelectionObject(
        title: 'Rear Entertainment System',
        value: 'rearEntertainment',
      ),
      SelectionObject(title: 'Premium Sound System', value: 'premiumSound'),
      SelectionObject(title: 'Heads-Up Display', value: 'headsUpDisplay'),
      SelectionObject(title: 'Navigation System', value: 'navigationSystem'),
      SelectionObject(title: 'Digital Display', value: 'digitalDisplay'),
    ];

    driverAssistance = [
      SelectionObject(title: 'Parking Sensors', value: 'parkingSensors'),
      SelectionObject(title: 'Cruise Control', value: 'cruiseControl'),
      SelectionObject(title: 'Reversing Camera', value: 'reversingCamera'),
      SelectionObject(
        title: 'Bird\'s Eye View Camera',
        value: 'birdsEyeCamera',
      ),
      SelectionObject(
        title: 'Digital Display Mirror',
        value: 'digitalDisplayMirror',
      ),
      SelectionObject(title: 'Automated Parking', value: 'automatedParking'),
      SelectionObject(
        title: 'Adaptive Cruise Control',
        value: 'adaptiveCruiseControl',
      ),
    ];

    interiorComfort = [
      SelectionObject(
        title: 'Steering Wheel Controls',
        value: 'steeringControls',
      ),
      SelectionObject(title: 'Paddle Shifters', value: 'paddleShifters'),
      SelectionObject(title: 'Auto-Dimming Mirror', value: 'autoDimmingMirror'),
      SelectionObject(title: 'Leather Seats', value: 'leatherSeats'),
      SelectionObject(title: 'Push Button Start', value: 'pushButtonStart'),
      SelectionObject(title: 'Remote Start', value: 'remoteStart'),
      SelectionObject(title: 'Ambient Lighting', value: 'ambientLighting'),
      SelectionObject(title: 'Keyless Entry', value: 'keylessEntry'),
      SelectionObject(title: 'Power Seats', value: 'powerSeats'),
      SelectionObject(title: 'Memory Seats', value: 'memorySeats'),
      SelectionObject(
        title: 'Power Folding Mirrors',
        value: 'powerFoldingMirrors',
      ),
      SelectionObject(title: 'Soft Close Doors', value: 'softCloseDoor'),
      SelectionObject(
        title: 'Electric Running Board',
        value: 'electricRunningBoard',
      ),
      SelectionObject(title: 'Hands-Free Liftgate', value: 'handsFreeLifgate'),
      SelectionObject(title: 'Massage Seats', value: 'massageSeats'),
      SelectionObject(title: 'Heated/Cooled Seats', value: 'heatedCooledSeats'),
      SelectionObject(title: 'Lumbar Support', value: 'lumbarSupport'),
    ];

    maintenanceModifications = [
      SelectionObject(title: 'New Brake Pads', value: 'newBrakePads'),
      SelectionObject(title: 'Agency Maintained', value: 'agencyMaintained'),
      SelectionObject(
        title: 'Special Modifications',
        value: 'specialModifications',
      ),
      SelectionObject(title: 'New Battery', value: 'newBattery'),
      SelectionObject(title: 'New Tires', value: 'newTyres'),
      SelectionObject(
        title: 'Premium Accessories',
        value: 'premiumAccessories',
      ),
    ];
    notifyListeners();
  }

  List<SelectionObject> generateYearSelections() {
    final currentYear = DateTime.now().year;
    return List.generate(currentYear - 1900 + 1, (i) {
      final year = currentYear - i;
      return SelectionObject(title: year.toString(), value: year.toString());
    });
  }

  ///fetch models
  Future<void> fetchModels(BuildContext context, String makeId) async {
    try {
      final response = await ApiManager.get(
        "${ApiEndpoint.carsMakes}/$makeId/models",
      ); // Fixed endpoint
      PrintLogs.printLog("fetchModels: $response");

      if (response['status'] == true) {
        if (response['data'] is List) {
          modelList.clear();
          for (var item in response['data']) {
            modelList.add(
              SelectionObject(
                id: item['id']?.toString() ?? '',
                title: item['name']?.toString() ?? '',
                value: item['slug']?.toString() ?? '',
                isActive: item['isActive'] == true,
              ),
            );
          }
          notifyListeners();
        }
      }
    } catch (e) {
      PrintLogs.printLog("fetchMakes error: $e");
    }
  }

  void updateLoader(bool val) {
    isLoading = val;
    notifyListeners();
  }

  ///step 1
  Future<bool?> postCarBasic({bool isEdit = false}) async {
    updateLoader(true);
    try {
      if (year == null) {
        AppAlerts.showSnackBar('Enter valid year', statusCode: 1);
        return null;
      } else if (mileage == null && mileage!.isEmpty) {
        AppAlerts.showSnackBar('Enter valid mileage', statusCode: 1);
        return null;
      } else if (condition == null) {
        AppAlerts.showSnackBar('Enter valid condittion', statusCode: 1);
        return null;
      } else if (regionSpec == null) {
        AppAlerts.showSnackBar('Enter valid region specs', statusCode: 1);
        return null;
      }
      // else if(engineSize == null){
      //   AppAlerts.showSnackBar('Enter valid engine size',statusCode: 1);
      //   return null;
      // }
      // else if(optionalLevel == null){
      //   AppAlerts.showSnackBar('Enter valid option level',statusCode: 1);
      //   return null;
      // }
      else if (bodyType == null) {
        AppAlerts.showSnackBar('Enter valid body type', statusCode: 1);
        return null;
      } else if (transmission == null) {
        AppAlerts.showSnackBar('Enter valid transmission', statusCode: 1);
        return null;
      }
      // else if(driveType == null){
      //   AppAlerts.showSnackBar('Enter valid drive type',statusCode: 1);
      //   return null;
      // }
      else if (noOfSeats == null && noOfSeats!.isEmpty) {
        AppAlerts.showSnackBar('Enter valid no of seats', statusCode: 1);
        return null;
      } else if (fuelType == null) {
        AppAlerts.showSnackBar('Enter valid fuel type', statusCode: 1);
        return null;
      } else if (color == null) {
        AppAlerts.showSnackBar('Enter valid color', statusCode: 1);
        return null;
      } else if (city == null || city?.id == '' || city?.id == null) {
        AppAlerts.showSnackBar('Enter valid city', statusCode: 1);
        return null;
      } else if (cylinder == null) {
        AppAlerts.showSnackBar('Enter valid cylinder', statusCode: 1);
        return null;
      } else if (make == null) {
        AppAlerts.showSnackBar('Enter valid make', statusCode: 1);
        return null;
      } else if (model == null) {
        AppAlerts.showSnackBar('Enter valid model', statusCode: 1);
        return null;
      }
      // else if(variant == null && variant!.isEmpty){
      //   AppAlerts.showSnackBar('Enter valid variant',statusCode: 1);
      //   return null;
      // }
      else if (noOfSeats != null &&
          noOfSeats!.isNotEmpty &&
          int.parse(noOfSeats!) > 20 &&
          int.parse(noOfSeats!) <= 0) {
        AppAlerts.showSnackBar('Enter valid seats', statusCode: 1);
        return null;
      }
      var body = {
        "year": int.parse(year!.value),
        "mileage": int.parse(mileage!),
        "conditionType": condition?.value ?? '',
        "regionalSpecs": regionSpec?.value ?? '',
        "engineSize": engineSize?.value ?? '',
        "optionLevel": optionalLevel?.value ?? '',
        "bodyType": bodyType?.value ?? '',
        "transmission": transmission?.value ?? '',
        "driveType": driveType?.value ?? '',
        if (noOfSeats != null && noOfSeats != "")
          "noOfSeats": int.tryParse(noOfSeats!) ?? 2,
        "fuelType": fuelType?.value ?? '',
        if (variant != null) "variant": variant,
        "color": color?.value ?? '',
        "cityId": int.parse(city!.id),
        "cylinders": cylinder?.value ?? '',
        "modelId": int.parse(model!.id),
        "makeId": int.parse(make!.id),
      };
      PrintLogs.printLog("body : $body");
      dynamic response;
      if (carBasicModel.id.isNotEmpty) {
        response = await ApiManager.update(
          '${ApiEndpoint.customerCars}/${ApiEndpoint.basic}',
          body,
        );
      } else {
        response = await ApiManager.post(
          '${ApiEndpoint.customerCars}/${ApiEndpoint.basic}',
          body,
        );
      }
      PrintLogs.printLog("postCarBasic response: $response");
      if (response['status'] == true && response['data'] is Map) {
        carBasicModel = CarBasicModel.fromJson(response['data']);
        return true;
      } else {
        carBasicModel = CarBasicModel();
        HelperFunctions.handleApiMessages(response);
      }
      return false;
    } catch (e) {
      PrintLogs.printLog('Exception fetchCarDetails : $e');
      return false;
    } finally {
      updateLoader(false);
    }
  }

  ///step 2
  void updateHasRim(bool val) {
    hasAlloyRims = val;
    notifyListeners();
  }

  void updateCurrentlyFinanced(bool val) {
    currentlyFinanced = val;
    notifyListeners();
  }

  void updateFirstOwner(bool val) {
    firstOwner = val;
    notifyListeners();
  }

  Future<bool?> postCarDetail({bool isEdit = false}) async {
    updateLoader(true);
    int? rimSizeTemp;

    if (rimSize.isNotEmpty) {
      rimSizeTemp = int.tryParse(rimSize);
      if (rimSizeTemp == null) {
        AppAlerts.showSnackBar('Enter valid seats', statusCode: 1);
        return null;
      } else if (rimSizeTemp <= 0 || rimSizeTemp > 10) {
        AppAlerts.showSnackBar('Enter valid seats', statusCode: 1);
        return null;
      }
    }
    try {
      Map<String, dynamic> body = {
        "overallCondition": overAllCondition?.value ?? '',
        "isAccidented": accidentHistory?.value ?? '',
        "accidentDetail": accidentDetails,
        "airBagsCondition": airBagsCondition?.value ?? '',
        "chassisCondition": chassisCondition?.value ?? '',
        "engineCondition": engineCondition?.value ?? '',
        "gearBoxCondition": gearBoxCondition?.value ?? '',
        "alloyRims": hasAlloyRims,
        "rimSize": rimSizeTemp,
        "roofType": roofType?.value ?? '',
        "currentlyFinanced": currentlyFinanced,
        "firstOwner": firstOwner,
        "specialAboutCar": specialAboutCar,
      };
      dynamic response;
      if (isEdit) {
        response = await ApiManager.update(
          '${ApiEndpoint.customerCars}/${carBasicModel.id}/${ApiEndpoint.details}',
          body,
        );
      } else {
        response = await ApiManager.post(
          '${ApiEndpoint.customerCars}/${carBasicModel.id}/${ApiEndpoint.details}',
          body,
        );
      }
      PrintLogs.printLog("fetchCarDetails response: $response");
      if (response['status'] == true && response['data'] is Map) {
        // carDetailsModel = CarDetailsModel.fromJson(response['data']);
        return true;
      } else {
        HelperFunctions.handleApiMessages(response);
      }
      return false;
    } catch (e) {
      PrintLogs.printLog('Exception fetchCarDetails : $e');
      AppAlerts.showSnackBar(e.toString(), statusCode: 1);
      return false;
    } finally {
      updateLoader(false);
    }
  }

  ///step 3
  void addItem(SelectionObject item) {
    final exists = selectedFeatureItems.any((e) => e.value == item.value);

    if (item.isSelected) {
      if (!exists) {
        selectedFeatureItems.add(item);
      }
    } else {
      selectedFeatureItems.removeWhere((e) => e.value == item.value);
    }
    notifyListeners();
  }

  Future<bool?> postCarFeatures({bool isEdit = false}) async {
    updateLoader(true);
    try {
      Map<String, dynamic> body = {};
      // Map<String, dynamic> body = {
      //   "blindSpotMonitor": false,
      //   "laneKeepAssist": false,
      //   "preCollisionSystem": false,
      //   "ledHeadlights": true,
      //   "fogLights": true,
      //   "brakeAssist": false,
      //   "bluetooth": true,
      //   "carplay": true,
      //   "rearEntertainment": false,
      //   "premiumSound": true,
      //   "headsUpDisplay": false,
      //   "parkingSensors": true,
      //   "cruiseControl": true,
      //   "navigationSystem": true,
      //   "reversingCamera": true,
      //   "birdsEyeCamera": false,
      //   "digitalDisplayMirror": false,
      //   "automatedParking": false,
      //   "adaptiveCruiseControl": false,
      //   "digitalDisplay": true,
      //   "steeringControls": true,
      //   "paddleShifters": false,
      //   "autoDimmingMirror": true,
      //   "leatherSeats": true,
      //   "pushButtonStart": true,
      //   "remoteStart": false,
      //   "ambientLighting": true,
      //   "keylessEntry": true,
      //   "powerSeats": true,
      //   "memorySeats": false,
      //   "powerFoldingMirrors": true,
      //   "softCloseDoor": false,
      //   "electricRunningBoard": false,
      //   "handsFreeLifgate": false,
      //   "massageSeats": false,
      //   "heatedCooledSeats": true,
      //   "lumbarSupport": true,
      //   "newBrakePads": false,
      //   "agencyMaintained": true,
      //   "specialModifications": false,
      //   "newBattery": false,
      //   "newTyres": true,
      // };

      for (var element in selectedFeatureItems) {
        body[element.value] = true;
      }

      dynamic response;
      if (isEdit) {
        response = await ApiManager.update(
          '${ApiEndpoint.customerCars}/${carBasicModel.id}/${ApiEndpoint.features}',
          body,
        );
      } else {
        response = await ApiManager.post(
          '${ApiEndpoint.customerCars}/${carBasicModel.id}/${ApiEndpoint.features}',
          body,
        );
      }
      PrintLogs.printLog("fetchCarDetails response: $response");
      if (response['status'] == true && response['data'] is Map) {
        // carDetailsModel = CarDetailsModel.fromJson(response['data']);
        return true;
      } else {
        HelperFunctions.handleApiMessages(response);
      }
      return false;
    } catch (e) {
      PrintLogs.printLog('Exception fetchCarDetails : $e');
      AppAlerts.showSnackBar(e.toString(), statusCode: 1);
      return false;
    } finally {
      updateLoader(false);
    }
  }

  ///step 4
  void pickImagesFromGallery() {
    HelperFunctions.pickMulitipleImage().then((val) {
      if (val != null) {
        if (val is List<XFile>) {
          for (var e in val) {
            CarImagesSelectionModel item = CarImagesSelectionModel();
            item.imageType = SelectionObject(title: 'Front Exterior', value: 'exterior_front');
            item.localPath = e.path; // device local path
            item.description.text = e.name; // image file name
            carImages.add(item);
          }
        }
        notifyListeners();
      }
    });
  }

  void removeImageFromList(int index) {
    carImages.removeAt(index);
    notifyListeners();
  }

  void updateImageType(int index, SelectionObject val) {
    carImages[index].imageType = val;
    notifyListeners();
  }

  Future<List<CarImagesSelectionModel>> uploadCarImages(
    BuildContext context,
    List<CarImagesSelectionModel> images,
  ) async {
    List<CarImagesSelectionModel> uploadedImages = [];

    for (var img in images) {
      try {
        if (img.localPath.isEmpty) {
          continue; // skip if no file
        }

        final file = File(img.localPath);
        final response = await ApiManager.uploadFile(
          ApiEndpoint.attachmentsUpload,
          file,
          fieldName: "file",
        );

        PrintLogs.printLog("uploadAttachment response: $response");

        if (response['status'] == true &&
            response['data'] != null &&
            response['data']['attachment'] is Map) {
          final attachmentData = response['data']['attachment'];

          // Update the model with new id
          img.id = attachmentData['id']?.toString() ?? '';
        } else {
          HelperFunctions.handleApiMessages(response);
        }
      } catch (e) {
        AppAlerts.showSnackBar('Upload failed: ${e.toString()}', statusCode: 1);
      }

      uploadedImages.add(img);
    }

    return uploadedImages;
  }

  Future<bool?> postCarDocuments(
    BuildContext context, {
    bool isEdit = false,
  }) async {
    try {
      updateLoader(true);
      var listOfImages = await uploadCarImages(context, carImages);
      var list = [];
      for (var e in listOfImages) {
        list.add(e.toJson());
      }
      Map<String, dynamic> body = {"documents": list};
      dynamic response;
      if (isEdit) {
        response = await ApiManager.update(
          '${ApiEndpoint.customerCars}/${carBasicModel.id}/${ApiEndpoint.documents}',
          body,
        );
      } else {
        response = await ApiManager.post(
          '${ApiEndpoint.customerCars}/${carBasicModel.id}/${ApiEndpoint.documents}',
          body,
        );
      }

      PrintLogs.printLog("fetchCarDetails response: $response");
      if (response['status'] == true && response['data'] is Map) {
        return true;
      }else{
        HelperFunctions.handleApiMessages(response);
      }
      return false;
    } catch (e) {
      PrintLogs.printLog('Exception fetchCarDetails : $e');
      AppAlerts.showSnackBar(e.toString(),statusCode: 1);
      return false;
    } finally {
      updateLoader(false);
    }
  }

  ///step 5
  Future<void> postCarPricing(BuildContext context,{bool isEdit = false}) async {
    updateLoader(true);
    try {
      Map<String, dynamic> body = {
        "listingPrice": int.tryParse(priceController.text.trim()) ?? 0,
        "isFeatured": isFeatureSelected,
      };
      dynamic response;
      if (isEdit) {
        response = await ApiManager.update(
          '${ApiEndpoint.customerCars}/${carBasicModel.id}/${ApiEndpoint.pricing}',
          body,
        );
      } else {
        response = await ApiManager.post(
          '${ApiEndpoint.customerCars}/${carBasicModel.id}/${ApiEndpoint.pricing}',
          body,
        );
      }
      PrintLogs.printLog("fetchCarDetails response: $response");
      if (response['status'] == true && response['data'] is Map) {
        Provider.of<CarListingProvider>(context,listen: false).fetchMyCars();
        Navigator.pop(context);
      } else {
        HelperFunctions.handleApiMessages(response);
      }
    } catch (e) {
      PrintLogs.printLog('Exception fetchCarDetails : $e');
      AppAlerts.showSnackBar(e.toString(),statusCode: 1);
    } finally {
      updateLoader(false);
    }
  }
}
