import 'package:car_wash_app/utils/api_endpoint.dart';

class CarBasicModel {
  String id = '';
  String year = '';
  String mileage = '';
  String makeId = '';
  String modelId = '';
  String variant = '';
  String color = '';
  String cityId = '';
  String conditionType = '';
  String listingPrice = '';
  String bodyType = '';
  String transmission = '';
  String fuelType = '';
  String engineSize = '';
  String noOfSeats = '';
  String driveType = '';
  String cylinders = '';
  String regionalSpecs = '';
  String optionLevel = '';
  String status = '';
  String createdAt = '';
  String updatedAt = '';
  String mainImageUrl = '';
  bool isFeatured = false;

  // step 2
  String carId = '';
  String overallCondition = '';
  String isAccidented = '';
  String accidentDetail = '';
  String airBagsCondition = '';
  String chassisCondition = '';
  String engineCondition = '';
  String gearBoxCondition = '';
  bool alloyRims = false;
  String rimSize = '';
  String roofType = '';
  bool currentlyFinanced = false;
  bool firstOwner = false;
  String specialAboutCar = '';
  String extraCreatedAt = '';
  String extraUpdatedAt = '';

  ///step 3

  CarBasicModel();

  /// From JSON
  CarBasicModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    year = json['year']?.toString() ?? '';
    mileage = json['mileage']?.toString() ?? '';
    makeId = json['makeId']?.toString() ?? '';
    modelId = json['modelId']?.toString() ?? '';
    variant = json['variant']?.toString() ?? '';
    color = json['color']?.toString() ?? '';
    cityId = json['cityId']?.toString() ?? '';
    conditionType = json['conditionType']?.toString() ?? '';
    listingPrice = json['listingPrice']?.toString() ?? '';
    bodyType = json['bodyType']?.toString() ?? '';
    transmission = json['transmission']?.toString() ?? '';
    fuelType = json['fuelType']?.toString() ?? '';
    engineSize = json['engineSize']?.toString() ?? '';
    noOfSeats = json['noOfSeats']?.toString() ?? '';
    driveType = json['driveType']?.toString() ?? '';
    cylinders = json['cylinders']?.toString() ?? '';
    regionalSpecs = json['regionalSpecs']?.toString() ?? '';
    optionLevel = json['optionLevel']?.toString() ?? '';
    status = json['status']?.toString() ?? '';
    createdAt = json['createdAt']?.toString() ?? '';
    updatedAt = json['updatedAt']?.toString() ?? '';
    if (json['isFeatured'] is bool) {
      isFeatured = json['isFeatured'];
    }

    mainImageUrl = json['mainImageUrl']?.toString() ?? '';
    if (mainImageUrl.isNotEmpty) {
      mainImageUrl = "${ApiEndpoint.imageBaseUrl}$mainImageUrl";
    }

  }

  CarBasicModel.parseDetails(Map<String, dynamic> json) {
    // These fields are not in your original model, so we add them here
    carId = json['carId']?.toString() ?? '';
    overallCondition = json['overallCondition']?.toString() ?? '';
    isAccidented = json['isAccidented']?.toString() ?? '';
    accidentDetail = json['accidentDetail']?.toString() ?? '';
    airBagsCondition = json['airBagsCondition']?.toString() ?? '';
    chassisCondition = json['chassisCondition']?.toString() ?? '';
    engineCondition = json['engineCondition']?.toString() ?? '';
    gearBoxCondition = json['gearBoxCondition']?.toString() ?? '';
    alloyRims = json['alloyRims'] is bool ? json['alloyRims'] : false;
    rimSize = json['rimSize']?.toString() ?? '';
    roofType = json['roofType']?.toString() ?? '';
    currentlyFinanced = json['currentlyFinanced'] is bool ? json['currentlyFinanced'] : false;
    firstOwner = json['firstOwner'] is bool ? json['firstOwner'] : false;
    specialAboutCar = json['specialAboutCar']?.toString() ?? '';
    extraCreatedAt = json['createdAt']?.toString() ?? '';
    extraUpdatedAt = json['updatedAt']?.toString() ?? '';
  }


  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'year': year,
      'mileage': mileage,
      'makeId': makeId,
      'modelId': modelId,
      'variant': variant,
      'color': color,
      'cityId': cityId,
      'conditionType': conditionType,
      'listingPrice': listingPrice,
      'bodyType': bodyType,
      'transmission': transmission,
      'fuelType': fuelType,
      'engineSize': engineSize,
      'noOfSeats': noOfSeats,
      'driveType': driveType,
      'cylinders': cylinders,
      'regionalSpecs': regionalSpecs,
      'optionLevel': optionLevel,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isFeatured': isFeatured,
      'mainImageUrl': mainImageUrl,

      // New
      'carId': carId,
      'overallCondition': overallCondition,
      'isAccidented': isAccidented,
      'accidentDetail': accidentDetail,
      'airBagsCondition': airBagsCondition,
      'chassisCondition': chassisCondition,
      'engineCondition': engineCondition,
      'gearBoxCondition': gearBoxCondition,
      'alloyRims': alloyRims,
      'rimSize': rimSize,
      'roofType': roofType,
      'currentlyFinanced': currentlyFinanced,
      'firstOwner': firstOwner,
      'specialAboutCar': specialAboutCar,
    };
  }

  /// CopyWith
  CarBasicModel copyWith({
    String? id,
    String? year,
    String? mileage,
    String? makeId,
    String? modelId,
    String? variant,
    String? color,
    String? cityId,
    String? conditionType,
    String? listingPrice,
    String? bodyType,
    String? transmission,
    String? fuelType,
    String? engineSize,
    String? noOfSeats,
    String? driveType,
    String? cylinders,
    String? regionalSpecs,
    String? optionLevel,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? mainImageUrl,
    bool? isFeatured,
  }) {
    return CarBasicModel()
      ..id = id ?? this.id
      ..year = year ?? this.year
      ..mileage = mileage ?? this.mileage
      ..makeId = makeId ?? this.makeId
      ..modelId = modelId ?? this.modelId
      ..variant = variant ?? this.variant
      ..color = color ?? this.color
      ..cityId = cityId ?? this.cityId
      ..conditionType = conditionType ?? this.conditionType
      ..listingPrice = listingPrice ?? this.listingPrice
      ..bodyType = bodyType ?? this.bodyType
      ..transmission = transmission ?? this.transmission
      ..fuelType = fuelType ?? this.fuelType
      ..engineSize = engineSize ?? this.engineSize
      ..noOfSeats = noOfSeats ?? this.noOfSeats
      ..driveType = driveType ?? this.driveType
      ..cylinders = cylinders ?? this.cylinders
      ..regionalSpecs = regionalSpecs ?? this.regionalSpecs
      ..optionLevel = optionLevel ?? this.optionLevel
      ..status = status ?? this.status
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..mainImageUrl = mainImageUrl ?? this.mainImageUrl
      ..isFeatured = isFeatured ?? this.isFeatured;
  }
}
